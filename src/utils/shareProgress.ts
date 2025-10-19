// Share Progress Utility
// Generates shareable content for user progress

export interface ShareData {
  xp: number;
  streak: number;
  lessonsCompleted: number;
  totalStars: number;
  level: number;
}

export async function shareProgress(data: ShareData): Promise<void> {
  const text = `Relingo - Læring om Religioner

Min fremgang:
Level ${data.level} - ${data.xp} XP
${data.streak} dagers streak
${data.lessonsCompleted} leksjoner fullført
${data.totalStars} stjerner samlet

Bli med meg på Relingo og lær om verdensreligioner!

#Relingo #Læring #Religion #Kunnskap`;

  // Check if Web Share API is available
  if (navigator.share) {
    try {
      await navigator.share({
        title: 'Min Relingo Fremgang',
        text: text,
        url: window.location.origin,
      });
      console.log('Shared successfully');
    } catch (error) {
      // User cancelled or error occurred
      if ((error as Error).name !== 'AbortError') {
        fallbackShare(text);
      }
    }
  } else {
    fallbackShare(text);
  }
}

function fallbackShare(text: string): void {
  // Fallback: Copy to clipboard
  navigator.clipboard.writeText(text).then(
    () => {
      alert('Fremgangen din er kopiert til utklippstavlen!\n\nLim inn hvor du vil dele.');
    },
    () => {
      // If clipboard also fails, show text in alert
      alert('Del din fremgang:\n\n' + text);
    }
  );
}

// Generate shareable image (future enhancement)
export async function generateShareImage(data: ShareData): Promise<Blob> {
  const canvas = document.createElement('canvas');
  const ctx = canvas.getContext('2d');
  
  if (!ctx) throw new Error('Canvas not supported');
  
  canvas.width = 1200;
  canvas.height = 630; // Twitter/Facebook card size
  
  // Background gradient
  const gradient = ctx.createLinearGradient(0, 0, 1200, 630);
  gradient.addColorStop(0, '#2ED573');
  gradient.addColorStop(1, '#1ABC9C');
  ctx.fillStyle = gradient;
  ctx.fillRect(0, 0, 1200, 630);
  
  // White overlay
  ctx.fillStyle = 'rgba(255, 255, 255, 0.1)';
  ctx.fillRect(0, 0, 1200, 630);
  
  // Title
  ctx.fillStyle = '#ffffff';
  ctx.font = 'bold 72px Inter, sans-serif';
  ctx.textAlign = 'center';
  ctx.fillText('Min Relingo Fremgang', 600, 100);
  
  // Stats
  ctx.font = 'bold 48px Inter, sans-serif';
  ctx.fillText(`Level ${data.level}`, 600, 200);
  
  ctx.font = '36px Inter, sans-serif';
  ctx.fillText(`${data.xp} XP  •  ${data.streak} dager streak`, 600, 280);
  ctx.fillText(`${data.lessonsCompleted} leksjoner  •  ${data.totalStars} stjerner`, 600, 340);
  
  // Footer
  ctx.font = '28px Inter, sans-serif';
  ctx.fillStyle = 'rgba(255, 255, 255, 0.9)';
  ctx.fillText('Relingo - Lær om verdensreligioner', 600, 550);
  
  return new Promise((resolve) => {
    canvas.toBlob((blob) => {
      if (blob) resolve(blob);
    }, 'image/png');
  });
}

