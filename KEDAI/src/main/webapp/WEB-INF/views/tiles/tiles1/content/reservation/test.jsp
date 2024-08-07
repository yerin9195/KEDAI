<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hover Table Example</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #e68c0e;
            color: white;
        }
        .tooltip {
            position: relative;
            display: inline-block;
            cursor: pointer;
        }
        .tooltip .tooltiptext {
            visibility: hidden;
            width: 200px;
            background-color: #555;
            color: #fff;
            text-align: center;
            border-radius: 5px;
            padding: 5px 0;
            position: absolute;
            z-index: 1;
            bottom: 125%;
            left: 50%;
            margin-left: -100px;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .tooltip .tooltiptext::after {
            content: "";
            position: absolute;
            top: 100%;
            left: 50%;
            margin-left: -5px;
            border-width: 5px;
            border-style: solid;
            border-color: #555 transparent transparent transparent;
        }
        .tooltip:hover .tooltiptext {
            visibility: visible;
            opacity: 1;
        }
    </style>
</head>
<body>
    <div style="width: 90%; margin: auto; padding: 20px;">
        <h2>Hover Table Example</h2>
        <table>
            <thead>
                <tr>
                    <th>No</th>
                    <th>Item Name</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td class="tooltip">
                        Item 1
                        <span class="tooltiptext">Item 1 Full Name</span>
                    </td>
                    <td>Description 1</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td class="tooltip">
                        Item 2
                        <span class="tooltiptext">Item 2 Full Name</span>
                    </td>
                    <td>Description 2</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td class="tooltip">
                        Item 3
                        <span class="tooltiptext">Item 3 Full Name</span>
                    </td>
                    <td>Description 3</td>
                </tr>
            </tbody>
        </table>
    </div>
    <script>
        $(document).ready(function(){
            // JavaScript logic if needed
        });
    </script>
</body>
</html>
