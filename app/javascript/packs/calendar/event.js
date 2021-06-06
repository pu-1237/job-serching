import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import googleCalendarPlugin from '@fullcalendar/google-calendar';

document.addEventListener('turbolinks:load', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new Calendar(calendarEl, {
        //日付の'日'表示を消す
        dayCellContent: function(e) {
            e.dayNumberText = e.dayNumberText.replace('日', '');
        },
        plugins: [ dayGridPlugin, interactionPlugin, googleCalendarPlugin ], 
        googleCalendarApiKey: 'AIzaSyAZM90quGfy0sLog_0O1cMAK04P59_9bjg',
        eventSources: [
            {
                googleCalendarId: 'ja.japanese#holiday@group.v.calendar.google.com',
                display: 'background',
                className: 'event_holiday'
            }
        ],
        //カレンダーに予定を表示させる
        //'/コントローラー名.json'形式で記述
        events: '/events.json',

        //細かな表示設定
        locale: 'ja',
        timeZone: 'Asia/Tokyo',
        firstDay: 1,
        headerToolbar: {
        start: '',
        center: 'title',
        end: 'today prev,next' 
        },
        expandRows: true,
        stickyHeaderDates: true,
        buttonText: {
        today: '今日'
        }, 
        allDayText: '終日',
        height: "auto",
        eventDisplay: 'block',
        navLinks: true, //日付クリックで遷移

        //日付クリック時の処理//
        dateClick: function(date, jsEvent, view){

        },
        //イベントクリック時の処理//
        eventClick: function(info) {
            // infoからevent.idを取得
            var event = calendar.getEventById(info.event.id);
            // urlにevet.idを埋め込んでページ遷移
            window.location.href = "events/" + event.id;
        },
        eventClassNames: function(arg){
            //表示されたイベントにclassをcss用に追加する
        },
    });
    
    calendar.render();
});