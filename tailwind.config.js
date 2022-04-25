const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
    purge: [
        "./vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php",
        "./storage/framework/views/*.php",
        "./resources/views/**/*.blade.php",
        "./resources/**/*.vue",
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: ["Inter", "Ubuntu", ...defaultTheme.fontFamily.sans],
                serif: ["Aclonica", ...defaultTheme.fontFamily.serif],
                heading: ["IBM Plex Sans", ...defaultTheme.fontFamily.sans],
            },
            colors: {
                vert: "#B2D06B",
                vN: "#0B3434",
                jaune: "#FFBC3E",
                nav: "#0B3434",

                gris: "#EEEEF2",
                lightVert: "#B2D06B54",
                lighterVert: "#B2D06B17",
                tableBorder: "#EEEEF2",
                bleu: "#0B3434",
            },
            zIndex: {
                100: "100",
            },
        },
    },

    variants: {
        extend: {
            opacity: ["disabled"],
        },
    },

    plugins: [],
};
