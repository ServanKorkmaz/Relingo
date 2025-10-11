import { useState, useRef, useEffect } from 'react';
import { Camera, Upload, X, Loader2 } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { supabase } from '../lib/supabase';
import { useQueryClient } from '@tanstack/react-query';

interface ProfileImageUploadProps {
  currentImageUrl?: string;
  userId: string;
  onClose: () => void;
}

export default function ProfileImageUpload({
  currentImageUrl,
  userId,
  onClose,
}: ProfileImageUploadProps) {
  const [uploading, setUploading] = useState(false);
  const [preview, setPreview] = useState<string | null>(null);
  const [showCamera, setShowCamera] = useState(false);
  const [stream, setStream] = useState<MediaStream | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const videoRef = useRef<HTMLVideoElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const queryClient = useQueryClient();

  // Cleanup camera stream when component unmounts or camera closes
  useEffect(() => {
    return () => {
      if (stream) {
        stream.getTracks().forEach(track => track.stop());
      }
    };
  }, [stream]);

  const startCamera = async () => {
    try {
      // Check if mediaDevices is supported
      if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
        alert('Din nettleser støtter ikke kamera-tilgang. Prøv Chrome, Firefox eller Edge.');
        return;
      }

      // Try different camera configurations with fallbacks
      let mediaStream: MediaStream | null = null;
      const configs = [
        // Try HD first
        { video: { width: 1280, height: 720, facingMode: 'user' }, audio: false },
        // Fallback to SD
        { video: { width: 640, height: 480, facingMode: 'user' }, audio: false },
        // Fallback without facingMode
        { video: { width: 640, height: 480 }, audio: false },
        // Fallback to basic video only
        { video: true, audio: false },
      ];

      for (const config of configs) {
        try {
          mediaStream = await navigator.mediaDevices.getUserMedia(config);
          console.log('Camera started with config:', config);
          break; // Success, exit loop
        } catch (e) {
          console.log('Failed with config:', config, e);
          // Try next config
        }
      }

      if (!mediaStream) {
        throw new Error('Could not start camera with any configuration');
      }
      
      setStream(mediaStream);
      setShowCamera(true);
      
      // Wait for next tick to ensure video element is rendered
      setTimeout(() => {
        if (videoRef.current) {
          videoRef.current.srcObject = mediaStream;
        }
      }, 100);
    } catch (error: any) {
      console.error('Error accessing camera:', error);
      
      let errorMessage = 'Kunne ikke få tilgang til kameraet.\n\n';
      
      if (error.name === 'NotAllowedError' || error.name === 'PermissionDeniedError') {
        errorMessage += '❌ Tilgang nektet\n\nDu må gi tillatelse til kamera:\n1. Klikk på kamera-ikonet i adressefeltet\n2. Velg "Tillat"\n3. Oppdater siden';
      } else if (error.name === 'NotFoundError' || error.name === 'DevicesNotFoundError') {
        errorMessage += '❌ Ingen kamera funnet\n\nSjekk at:\n• Kameraet er tilkoblet (USB)\n• Kameraet fungerer i andre apper\n• Drivere er installert';
      } else if (error.name === 'NotReadableError' || error.name === 'TrackStartError') {
        errorMessage += '❌ Kameraet er opptatt\n\nLukk andre programmer som bruker kamera:\n• Zoom\n• Teams\n• Skype\n• Andre nettleser-faner';
      } else if (error.name === 'OverconstrainedError') {
        errorMessage += '❌ Kamera støtter ikke innstillingene\n\nPrøv "Velg fra filer" i stedet.';
      } else if (error.name === 'SecurityError') {
        errorMessage += '❌ Sikkerhetsfeil\n\nSjekk at du bruker HTTPS eller localhost.';
      } else {
        errorMessage += `Feil: ${error.message}\n\nPrøv "Velg fra filer" i stedet.`;
      }
      
      alert(errorMessage);
    }
  };

  const stopCamera = () => {
    if (stream) {
      stream.getTracks().forEach(track => track.stop());
      setStream(null);
    }
    setShowCamera(false);
  };

  const capturePhoto = () => {
    if (!videoRef.current || !canvasRef.current) return;

    const video = videoRef.current;
    const canvas = canvasRef.current;
    const context = canvas.getContext('2d');

    if (!context) return;

    // Set canvas size to match video
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;

    // Draw current video frame to canvas
    context.drawImage(video, 0, 0, canvas.width, canvas.height);

    // Convert canvas to blob
    canvas.toBlob((blob) => {
      if (blob) {
        // Create a file from the blob
        const file = new File([blob], `camera-${Date.now()}.jpg`, {
          type: 'image/jpeg',
        });
        
        // Stop camera
        stopCamera();
        
        // Upload the captured image
        uploadImage(file);
      }
    }, 'image/jpeg', 0.95);
  };

  const uploadImage = async (file: File) => {
    try {
      setUploading(true);

      // Validate file size (max 5MB)
      if (file.size > 5 * 1024 * 1024) {
        alert('Bildet er for stort. Maks 5MB.');
        return;
      }

      // Validate file type
      if (!file.type.startsWith('image/')) {
        alert('Vennligst velg et bilde.');
        return;
      }

      // Create unique filename
      const fileExt = file.name.split('.').pop();
      const fileName = `${userId}-${Date.now()}.${fileExt}`;
      const filePath = `avatars/${fileName}`;

      // Upload to Supabase Storage
      const { error: uploadError } = await supabase.storage
        .from('avatars')
        .upload(filePath, file, {
          cacheControl: '3600',
          upsert: false,
        });

      if (uploadError) {
        throw uploadError;
      }

      // Get public URL
      const { data: urlData } = supabase.storage
        .from('avatars')
        .getPublicUrl(filePath);

      const publicUrl = urlData.publicUrl;

      // Update user metadata
      const { error: updateError } = await supabase.auth.updateUser({
        data: {
          avatar_url: publicUrl,
        },
      });

      if (updateError) {
        throw updateError;
      }

      // Delete old avatar if exists
      if (currentImageUrl && currentImageUrl.includes('avatars/')) {
        const oldPath = currentImageUrl.split('avatars/')[1];
        if (oldPath && !oldPath.startsWith('avatar')) {
          // Don't delete default avatars
          await supabase.storage.from('avatars').remove([`avatars/${oldPath}`]);
        }
      }

      // Invalidate queries to refresh UI
      queryClient.invalidateQueries({ queryKey: ['auth-user'] });
      
      onClose();
    } catch (error: any) {
      console.error('Error uploading image:', error);
      alert(error.message || 'Kunne ikke laste opp bilde. Prøv igjen.');
    } finally {
      setUploading(false);
    }
  };

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      // Show preview
      const reader = new FileReader();
      reader.onloadend = () => {
        setPreview(reader.result as string);
      };
      reader.readAsDataURL(file);

      // Upload
      uploadImage(file);
    }
  };

  return (
    <AnimatePresence>
      <motion.div
        className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        onClick={onClose}
      >
        <motion.div
          className="bg-white rounded-2xl p-6 max-w-sm w-full"
          initial={{ scale: 0.9, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          exit={{ scale: 0.9, opacity: 0 }}
          onClick={(e) => e.stopPropagation()}
        >
          {/* Header */}
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-xl font-bold text-gray-900">
              Velg profilbilde
            </h2>
            <button
              onClick={onClose}
              className="p-2 hover:bg-gray-100 rounded-full transition-colors"
              disabled={uploading}
            >
              <X className="w-5 h-5 text-gray-600" />
            </button>
          </div>

          {/* Preview */}
          {preview && (
            <div className="mb-6 flex justify-center">
              <div className="w-32 h-32 rounded-full overflow-hidden border-4 border-brand">
                <img
                  src={preview}
                  alt="Preview"
                  className="w-full h-full object-cover"
                />
              </div>
            </div>
          )}

          {/* Camera View */}
          {showCamera ? (
            <div className="space-y-4">
              <div className="relative bg-black rounded-xl overflow-hidden">
                <video
                  ref={videoRef}
                  autoPlay
                  playsInline
                  className="w-full h-64 object-cover"
                />
                <canvas ref={canvasRef} className="hidden" />
              </div>

              <div className="flex gap-3">
                <button
                  onClick={stopCamera}
                  className="flex-1 py-3 border border-gray-300 text-gray-700 font-medium rounded-xl hover:bg-gray-50 transition-colors"
                >
                  Avbryt
                </button>
                <button
                  onClick={capturePhoto}
                  disabled={uploading}
                  className="flex-1 py-3 bg-brand text-white font-semibold rounded-xl hover:bg-brand-dark transition-colors flex items-center justify-center gap-2 disabled:opacity-50"
                >
                  <Camera className="w-5 h-5" />
                  Ta bilde
                </button>
              </div>
            </div>
          ) : (
            <>
              {/* Upload Options */}
              <div className="space-y-3">
                {/* File Input - for selecting from files */}
                <input
                  ref={fileInputRef}
                  type="file"
                  accept="image/*"
                  onChange={handleFileSelect}
                  className="hidden"
                  disabled={uploading}
                />

                {/* Take Photo Button - opens webcam */}
                <button
                  onClick={startCamera}
                  disabled={uploading}
                  className="w-full py-4 bg-brand text-white font-semibold rounded-xl hover:bg-brand-dark transition-colors flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {uploading ? (
                    <>
                      <Loader2 className="w-5 h-5 animate-spin" />
                      Laster opp...
                    </>
                  ) : (
                    <>
                      <Camera className="w-5 h-5" />
                      Åpne kamera
                    </>
                  )}
                </button>

                {/* Choose from Files Button */}
                <button
                  onClick={() => fileInputRef.current?.click()}
                  disabled={uploading}
                  className="w-full py-4 bg-gray-100 text-gray-900 font-semibold rounded-xl hover:bg-gray-200 transition-colors flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {uploading ? (
                    <>
                      <Loader2 className="w-5 h-5 animate-spin" />
                      Laster opp...
                    </>
                  ) : (
                    <>
                      <Upload className="w-5 h-5" />
                      Velg fra filer
                    </>
                  )}
                </button>
              </div>
            </>
          )}

          {/* Info Text */}
          {!showCamera && (
            <p className="text-sm text-gray-500 text-center mt-4">
              Åpne webkamera eller velg fra filer
              <br />
              Maks filstørrelse: 5MB • JPG, PNG, GIF
            </p>
          )}
        </motion.div>
      </motion.div>
    </AnimatePresence>
  );
}

