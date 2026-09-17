// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

document.addEventListener("turbo:load", () => {
  const hamburgerBtn = document.getElementById("hamburger-btn");
  const sidebar = document.getElementById("sidebar");

  if (hamburgerBtn && sidebar) {
    // 重複してイベントが登録されるのを防ぐ（Turbo環境での対策）
    const newBtn = hamburgerBtn.cloneNode(true);
    hamburgerBtn.parentNode.replaceChild(newBtn, hamburgerBtn);

    newBtn.addEventListener("click", () => {
      // is-open クラスを付け外し（トグル）する
      sidebar.classList.toggle("is-open");
    });
  }
});