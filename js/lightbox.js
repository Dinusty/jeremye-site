// Lightbox for gallery, press and blog images (not the home page carousel).
(function () {
  const items = [...document.querySelectorAll('.masonry a, .press a, .post img')];
  if (!items.length) return;

  const srcOf = (el) => (el.tagName === 'A' ? el.getAttribute('href') : el.getAttribute('src'));
  const altOf = (el) => (el.tagName === 'A' ? el.querySelector('img')?.alt : el.alt) || '';

  const box = document.createElement('dialog');
  box.className = 'lightbox';
  box.setAttribute('aria-label', 'Image viewer');
  box.innerHTML = `
    <button class="lb-close" type="button" aria-label="Close">&times;</button>
    <button class="lb-prev" type="button" aria-label="Previous image">&#8249;</button>
    <figure><img alt=""><figcaption></figcaption></figure>
    <button class="lb-next" type="button" aria-label="Next image">&#8250;</button>`;
  document.body.appendChild(box);

  const img = box.querySelector('img');
  const cap = box.querySelector('figcaption');
  let i = 0;

  function show(n) {
    i = (n + items.length) % items.length;
    img.src = srcOf(items[i]);
    img.alt = altOf(items[i]);
    cap.textContent = altOf(items[i]);
    box.classList.toggle('single', items.length < 2);
  }

  items.forEach((el, n) => {
    if (el.tagName === 'IMG') { el.style.cursor = 'zoom-in'; el.tabIndex = 0; el.setAttribute('role', 'button'); }
    const open = (e) => { e.preventDefault(); show(n); box.showModal(); };
    el.addEventListener('click', open);
    el.addEventListener('keydown', (e) => { if (el.tagName === 'IMG' && (e.key === 'Enter' || e.key === ' ')) open(e); });
  });

  box.querySelector('.lb-close').onclick = () => box.close();
  box.querySelector('.lb-prev').onclick = () => show(i - 1);
  box.querySelector('.lb-next').onclick = () => show(i + 1);
  box.addEventListener('click', (e) => { if (e.target === box || e.target.tagName === 'FIGURE') box.close(); });
  box.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowLeft') show(i - 1);
    if (e.key === 'ArrowRight') show(i + 1);
  });
})();
