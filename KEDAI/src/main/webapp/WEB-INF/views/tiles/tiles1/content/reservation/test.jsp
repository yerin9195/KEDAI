<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Modal with FullCalendar</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            height: 80%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        #calendar {
            height: 100%;
            width: 100%;
        }

        .fc-daygrid-day-clicked {
            position: relative;
            background-color: #f0f0f0;
        }

        .select-button {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 10;
            padding: 5px 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
    </style>
</head>
<body>

    <td align="center">
        <input type="button" value="Open Calendar" class="subject" id="openModalBtn" />
    </td>

    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div id="calendar"></div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Initialize the calendar
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                height: '100%',
                dateClick: function(info) {
                    // Remove existing select buttons
                    $('.select-button').remove();
                    // Remove background color from previously clicked cells
                    $('.fc-daygrid-day').removeClass('fc-daygrid-day-clicked');
                    // Add background color to clicked cell
                    $(info.dayEl).addClass('fc-daygrid-day-clicked');

                    // Create a new select button
                    var button = $('<button class="select-button">Select</button>');
                    // Append the button to the clicked cell
                    $(info.dayEl).append(button);

                    // Add click event to the button
                    button.click(function() {
                        alert('Date selected: ' + info.dateStr);
                        $('#myModal').hide(); // Close the modal
                        resetModal(); // Reset modal content
                    });
                }
            });

            // Get the modal
            var modal = $('#myModal');

            // Get the button that opens the modal
            var btn = $('#openModalBtn');

            // Get the <span> element that closes the modal
            var span = $('.close');

            // Function to reset the modal content
            function resetModal() {
                // Remove existing select buttons
                $('.select-button').remove();
                // Remove background color from previously clicked cells
                $('.fc-daygrid-day').removeClass('fc-daygrid-day-clicked');
            }

            // When the user clicks the button, open the modal and render the calendar
            btn.click(function() {
                resetModal(); // Ensure the modal is reset before showing
                modal.show();
                calendar.render();
            });

            // When the user clicks on <span> (x), close the modal and reset content
            span.click(function() {
                modal.hide();
                resetModal();
            });

            // When the user clicks anywhere outside of the modal, close it and reset content
            $(window).click(function(event) {
                if ($(event.target).is(modal)) {
                    modal.hide();
                    resetModal();
                }
            });

            // Ensure reset when the modal is hidden
            modal.on('hide', function() {
                resetModal();
            });
        });
    </script>
</body>
</html>
