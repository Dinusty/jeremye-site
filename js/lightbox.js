// Lightbox for gallery, press and blog images (not the home page grid).
// Darkened page, image fit to screen, close button only. Fades in and out.
(function () {
  const items = [...document.querySelectorAll('.masonry a, .press a, .post img')];
  if (!items.length) return;

  const srcOf = (el) => (el.tagName === 'A' ? el.getAttribute('href') : el.getAttribute('src'));
  const altOf = (el) => (el.tagName === 'A' ? el.querySelector('img')?.alt : el.alt) || '';
  const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  const DUR = reduce ? 0 : 300;

  const box = document.createElement('dialog');
  box.className = 'lightbox';
  box.setAttribute('aria-label', 'Image viewer');
  box.innerHTML = '<button class="lb-close" type="button" aria-label="Close">&times;</button><img alt="">';
  document.body.appendChild(box);
  const img = box.querySelector('img');
  let i = 0, closing = false;

  function load(n) {
    i = (n + items.length) % items.length;
    img.src = srcOf(items[i]);
    img.alt = altOf(items[i]);
  }
  function open(n) {
    load(n);
    box.showModal();
    requestAnimationFrame(() => requestAnimationFrame(() => box.classList.add('show')));
  }
  function close() {
    if (closing || !box.open) return;
    closing = true;
    box.classList.remove('show');
    setTimeout(() => { box.close(); closing = false; }, DUR);
  }
  function step(d) {
    img.classList.add('swap');
    setTimeout(() => {
      load(i + d);
      const done = () => img.classList.remove('swap');
      img.complete ? done() : img.addEventListener('load', done, { once: true });
    }, DUR / 2);
  }

  items.forEach((el, n) => {
    if (el.tagName === 'IMG') { el.style.cursor = 'zoom-in'; el.tabIndex = 0; el.setAttribute('role', 'button'); }
    const go = (e) => { e.preventDefault(); open(n); };
    el.addEventListener('click', go);
    el.addEventListener('keydown', (e) => { if (el.tagName === 'IMG' && (e.key === 'Enter' || e.key === ' ')) go(e); });
  });

  box.querySelector('.lb-close').onclick = close;
  box.addEventListener('click', (e) => { if (e.target !== img) close(); });
  box.addEventListener('cancel', (e) => { e.preventDefault(); close(); });   // Esc fades out too
  box.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowLeft') step(-1);
    if (e.key === 'ArrowRight') step(1);
  });
})();
