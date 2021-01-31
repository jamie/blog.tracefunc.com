module.exports = {
  purge: {
    mode: "all",
    content: [
      "./frontend/**/*.css",
      "./frontend/**/*.scss",
      "./src/**/*.erb",
      "./src/**/*.html",
      "./src/**/*.liquid",
      "./src/**/*.md",
    ],
  },
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
};
