<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="CM.cm_tran_year_web.WebForm1" %>

<!DOCTYPE html>

<html>
<head>
    <title></title>
    <script type="text/javascript" lang="javascript">

        function Mensaje() {

            document.getElementById("div1").style.height = "100px";

            /*
             div1.clientHeight = 100;
             alert('Hola:' + div1.clientHeight);
             document.getElementById("div1").style.height = "100px";
             //document.getElementById("Button1").style.height = "50px";
             alert('Hola:' + div1.clientHeight);
             //document.getElementById('div1').style.display = 'block';
             document.getElementById('div1').setAttribute("style", "width:500px");
             
             //document.getElementById("Button1").clientHeight = "50px";
             //document.getElementById('Button1').he
             
             
             //Button1.clientHeight = 50;
             */

            alert('Hola:' + div1.clientHeight);

            /*
            var div = document.getElementById("div1");
            var h = 100;
            if (h >= 1) {
                div.style.height = h + "px"; // I'm using "em" instead of "px", but you can use px like measure...
            }
            */
            //document.getElementById("div1").style.height = "100px"



         }

 </script>
<script type="text/javascript">

        function Div(id,ud) {
           var div=document.getElementById(id);
           var h=parseInt(div.style.height)+ud;
           if (h>=1){
              div.style.height = h + "px"; // I'm using "em" instead of "px", but you can use px like measure...
           }
        }

        function Div2(id, ud) {
            var div = document.getElementById(id);
            var h = ud;
            if (h >= 1) {
                div.style.height = h + "px"; // I'm using "em" instead of "px", but you can use px like measure...
            }
        }

        window.onload = function () {
            fgvDivToFooter("div1", "divFooter");
        };

        window.onresize = function(event) {
            
            fgvDivToFooter("div1", "divFooter");

        };

        function fgvDivToFooter(vpsDivId, vpsDivFooterId) {
            var vloDiv = document.getElementById(vpsDivId);
            var vloDivFooter = document.getElementById(vpsDivFooterId);
            vloDiv.style.height = (vloDivFooter.offsetTop - vloDiv.offsetTop - 10) + "px";
        }

    </script>

    <style type="text/css">
        .auto-style1 {
            height: 178px;
        }
        .auto-style2 {
            height: 43px;
        }


        .footer {
           position:absolute;
           bottom:0;
           width:100%;
           height:60px;   /* Height of the footer */
           background:#6cf;
        }
    </style>
</head>
<body>
    <form id="form1"  dir="auto" runat="server">
    <div id="divForm" style="border: medium solid #0000FF;">   
        <asp:Button ID="Button1" runat="server" Text="Button" />   
        <div id="div1" style="height: 50px; width: 100px; overflow: auto; border: medium solid #0000FF;">
            <button onclick="Div2('div1',100);">Uno</button>
            <button onclick="Mensaje();">Dos</button>
            <input type="button" value="+" onclick="Div('div1', 1);">   
            <input type="button" value="+" onclick="Div2('div1', 100);">          
        </div>
        <div id="divFooter" class ="footer" style="height: 60px;"">

        </div>
    </div>
    </form>
</body>
</html>
