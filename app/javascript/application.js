// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

document.addEventListener("turbo:load", () => {
  // ▼ IDを "search-menu-btn" に変更
  const searchBtn = document.getElementById("search-menu-btn");
  const sidebar = document.getElementById("sidebar");

  if (searchBtn && sidebar) {
    const newBtn = searchBtn.cloneNode(true);
    searchBtn.parentNode.replaceChild(newBtn, searchBtn);

    newBtn.addEventListener("click", () => {
      sidebar.classList.toggle("is-open");
    });
  }
});