<?php ?>

<div class="footer-spacer" aria-hidden="true"></div>

<footer class="site-footer">
    <div class="footer-content">
        <p>COPYRIGHT Copyright &copy; 2026</p>
        <p>ANUMA</p>
        <p>Todos los derechos reservados</p>
        
    </div>
</footer>

<script>
    (function () {
        function ajustarEspacioFooter() {
            var footer = document.querySelector('.site-footer');
            if (!footer) return;
            document.documentElement.style.setProperty('--footer-height', footer.offsetHeight + 'px');
        }

        window.addEventListener('load', ajustarEspacioFooter);
        window.addEventListener('resize', ajustarEspacioFooter);
    })();
</script>