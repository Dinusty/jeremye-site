// Crossfades between stages of the same space ("transformations").
(function () {
  const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  document.querySelectorAll('.prog').forEach((el) => {
    const frames = [...el.querySelectorAll('.prog-stage img')];
    const dots = [...el.querySelectorAll('.prog-dots button')];
    const toggle = el.querySelector('.prog-toggle');
    let i = 0, timer = null, playing = !reduce;

    function show(n) {
      i = (n + frames.length) % frames.length;
      frames.forEach((f, k) => f.classList.toggle('on', k === i));
      dots.forEach((d, k) => d.setAttribute('aria-current', k === i ? 'true' : 'false'));
    }
    function start() { stop(); timer = setInterval(() => show(i + 1), 2600); playing = true; toggle.textContent = 'Pause'; }
    function stop() { clearInterval(timer); timer = null; playing = false; toggle.textContent = 'Play'; }

    dots.forEach((d, k) => d.addEventListener('click', () => { stop(); show(k); }));
    toggle.addEventListener('click', () => (playing ? stop() : start()));
    el.querySelector('.prog-stage').addEventListener('click', () => (playing ? stop() : start()));

    // only animate while on screen
    const io = new IntersectionObserver(([e]) => {
      if (e.isIntersecting && playing && !timer) start();
      if (!e.isIntersecting && timer) { clearInterval(timer); timer = null; }
    }, { threshold: 0.3 });
    io.observe(el);
    show(0);
    if (!playing) toggle.textContent = 'Play';
  });
})();
