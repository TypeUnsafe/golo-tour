  $.ajax({
    type: "POST",
    url: "/bob",
    data: '{"message":"hello bob"}',
    success: function(data) {
      console.log("-->", data)
    }
  });