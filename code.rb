dateClick: function(date, jsEvent, view){
  var day = formatDate(info.event.start);
  location.href = "/events/datelist"
  $.ajax({
      url: "/events/datelist",
      type: "GET",
      dataType: 'html',
      async: 'true',
      data: {
          date: day
      }
  })
},


