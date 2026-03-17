   </div> <!-- end #mainContent -->
</div> <!-- end .layout -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
  function openSidebar(){
    document.body.classList.add("sidebar-open");
    document.body.classList.remove("sidebar-collapsed");
  }

  function closeSidebar(){
    document.body.classList.remove("sidebar-open");
    document.body.classList.add("sidebar-collapsed");
  }

  function toggleSidebar(){
    const isMobile = window.matchMedia("(max-width: 991.98px)").matches;
    if(isMobile){
      if(document.body.classList.contains("sidebar-open")) closeSidebar();
      else openSidebar();
    }else{
      document.body.classList.toggle("sidebar-collapsed");
    }
  }

  window.addEventListener("load", () => {
    const isMobile = window.matchMedia("(max-width: 991.98px)").matches;
    if(isMobile) closeSidebar();
    else document.body.classList.remove("sidebar-collapsed");
  });
</script>

</body>
</html>