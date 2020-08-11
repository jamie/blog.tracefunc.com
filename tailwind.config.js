module.exports = {
  purge: {
    mode: "production",
    content: [
      "./frontend/**/*.css",
      "./frontend/**/*.scss",
      "./src/**/*.erb",
      "./src/**/*.html",
      "./src/**/*.liquid",
      "./src/**/*.md",
      "./output/**/*.html",
    ],
  },
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
};
