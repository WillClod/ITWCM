﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="CM.cm_tran_mobil.WebForm2" %>

<!DOCTYPE html>

<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <script type="text/javascript">

        function Div(id,ud) {
           var div=document.getElementById(id);
           var h=parseInt(div.style.height)+ud;
           if (h>=1){
              div.style.height = h + "em"; // I'm using "em" instead of "px", but you can use px like measure...
           }
        }
    </script>

</head>
<body>
    <div>
        <input type="button" value="+" onclick="Div('my_div', 1);">&nbsp;&nbsp;
        <input type="button" value="-" onclick="Div('my_div', -1);">
    </div>
    <div id="my_div" style="height: 1em; width: 1em; overflow: auto; border: medium solid #0000FF;"></div>

</body>
</html>
