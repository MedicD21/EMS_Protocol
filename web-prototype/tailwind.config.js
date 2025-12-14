/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        emr: '#34C759',     // Green - Emergency Medical Responder
        emt: '#007AFF',     // Blue - Emergency Medical Technician
        aemt: '#FFD60A',    // Yellow - Advanced EMT
        paramedic: '#FF3B30', // Red - Paramedic
      },
    },
  },
  plugins: [],
}
