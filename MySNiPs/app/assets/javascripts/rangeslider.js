var slider = document.getElementById('slider');
if (slider != null) {
  document.getElementById('slider').innerHTML = "";
  noUiSlider.create(slider, {
    start: [0, 10],
    connect: true,
    range: {
      'min': 0,
      'max': 10
    }, step: 1
  });
  var selectmin = document.getElementById('min');
  var selectmax = document.getElementById('max');

  // Append the option elements
  for (var i = 0; i <= 10; i++) {

    var option = document.createElement("option");
    option.text = i;
    option.value = i;

    selectmin.appendChild(option);
  }
  for (var i = 0; i <= 10; i++) {

    var option = document.createElement("option");
    option.text = i;
    option.value = i;

    selectmax.appendChild(option);
  }


  var inputNumbermin = document.getElementById('min');
  var inputNumbermax = document.getElementById('max');

  slider.noUiSlider.on('update', function (values, handle) {

    var value = values[handle];

    if (handle == 0) {
      selectmin.value = Math.round(value);
    }
    else if (handle == 1) {
      selectmax.value = Math.round(value);
    }
  });
  if (min) {
    selectmin.value = Math.round(min);
    slider.noUiSlider.set([min, null]);
  }
  if (max) {
    selectmax.value = Math.round(max);
    slider.noUiSlider.set([null, max]);
  }

  selectmin.addEventListener('change', function () {
    slider.noUiSlider.set([this.value, null]);

  });
  selectmax.addEventListener('change', function () {
    slider.noUiSlider.set([null, this.value]);
  });
}