(function () {
  var reveals = document.querySelectorAll('[data-reveal]');
  var io = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        entry.target.classList.add('show');
        io.unobserve(entry.target);
      }
    });
  }, { threshold: 0.16 });

  reveals.forEach(function (el) {
    io.observe(el);
  });

  var form = document.querySelector('[data-lead-form]');
  var out = document.querySelector('[data-form-success]');
  if (!form || !out) return;

  form.addEventListener('submit', function (event) {
    event.preventDefault();
    var data = new FormData(form);
    var name = (data.get('name') || '').toString().trim();
    var email = (data.get('email') || '').toString().trim();
    var message = (data.get('message') || '').toString().trim();

    if (!name || !email || !message) {
      out.textContent = form.dataset.error || 'Please fill all required fields.';
      return;
    }

    out.textContent = form.dataset.success || 'Thanks, your request has been sent.';
    form.reset();
  });
})();
