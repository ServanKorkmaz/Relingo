import { motion } from 'framer-motion';

interface LessonPathProps {
  height?: number;
  color?: string;
}

export default function LessonPath({ height = 60, color = '#E5E7EB' }: LessonPathProps) {
  return (
    <div className="flex justify-center">
      <motion.div
        className="w-1 rounded-full"
        style={{
          height: `${height}px`,
          backgroundColor: color,
        }}
        initial={{ scaleY: 0 }}
        animate={{ scaleY: 1 }}
        transition={{ duration: 0.3 }}
      />
    </div>
  );
}
