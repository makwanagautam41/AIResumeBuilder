<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_Planes.aspx.cs" Inherits="airesumebuilder.Add_Planes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <center>
                <table border="1">
                    <tr>
                        <td>Enter Name</td>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Enter Monthly Price</td>
                        <td><asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Enter Annual Price</td>
                        <td><asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Enter Original Price</td>
                        <td><asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Enter Description</td>
                        <td><asp:TextBox ID="TextBox5" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Is Popular Plan</td>
                        <td>
                            <asp:CheckBox ID="CheckBox1" runat="server" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="Button1" runat="server" Text="Button" /></td>
                    </tr>
                </table>
            </center>
        </div>
    </form>
</body>
</html>
