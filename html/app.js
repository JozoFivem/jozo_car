$(document).ready(function () {
    window.addEventListener("message", function (event) {
      if (event.data.display == true) {
        $(".speedometer").fadeIn();
        $(".gasometer").fadeIn();
        $(".speed").text(event.data.speed);
        $(".gasoline").text(event.data.gasoline);
      } else {
        $(".speedometer").fadeOut();
        $(".gasometer").fadeOut();
      }
    });
  });