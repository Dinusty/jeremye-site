// Lightbox for gallery, press and blog images (not the home page carousel).
// Darkened page, image fit to screen, close button only. Arrow keys still browse.
(function () {
  const items = [...document.querySelectorAll('.masonry a, .press a, .post img')];
  if (!items.length) return;

  const srcOf = (el) => (el.tagName === 'A' ? el.getAttribute('href') : el.getAttribute('src'));
  const altOf = (el) => (el.tagName === 'A' ? el.querySelector('img')?.alt : el.alt) || '';

  const box = document.createElement('dialog');
  box.className = 'lightbox';
  box.setAttribute('aria-label', 'Image viewer');
  box.innerHTML = '<button class="lb-close" type="button" aria-label="Close">&times;</button><img alt="">';
  document.body.appendChild(box);
  const img = box.querySelector('img');
  let i = 0;

  function show(n) {
    i = (n + items.length) % items.length;
    img.src = srcOf(items[i]);
    img.alt = altOf(items[i]);
  }

  items.forEach((el, n) => {
    if (el.tagName === 'IMG') { el.style.cursor = 'zoom-in'; el.tabIndex = 0; el.setAttribute('role', 'button'); }
    const open = (e) => { e.preventDefault(); show(n); box.showModal(); };
    el.addEventListener('click', open);
    el.addEventListener('keydown', (e) => { if (el.tagName === 'IMG' && (e.key === 'Enter' || e.key === ' ')) open(e); });
  });

  box.querySelector('.lb-close').onclick = () => box.close();
  box.addEventListener('click', (e) => { if (e.target !== img) box.close(); });
  box.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowLeft') show(i - 1);
    if (e.key === 'ArrowRight') show(i + 1);
  });
})();
