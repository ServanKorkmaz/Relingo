import { fontFamily } from "tailwindcss/defaultTheme";

/** @type {import('tailwindcss').Config} */
export default {
  darkMode: ["class"],
  content: ["./index.html", "./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter", ...fontFamily.sans],
        display: ["Nunito", ...fontFamily.sans],
      },
      colors: {
        brand: {
          DEFAULT: "#2ED573", // main green
          dark: "#1ABC9C",
        },
        islam: "#0EA5E9",
        christianity: "#8B5CF6",
        hinduism: "#F59E0B",
        buddhism: "#EF4444",
        judaism: "#14B8A6",
        sikhism: "#22C55E",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
};
