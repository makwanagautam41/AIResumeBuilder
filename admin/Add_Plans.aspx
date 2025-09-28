<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_Plans.aspx.cs" Inherits="airesumebuilder.admin.Add_Plans" %>

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
                            <asp:TextBox ID="planName" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Enter Monthly Price</td>
                        <td>
                            <asp:TextBox ID="planMonthlyPrice" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Enter Annual Price</td>
                        <td>
                            <asp:TextBox ID="planAnnualPrice" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Enter Original Price</td>
                        <td>
                            <asp:TextBox ID="planOriginalPrice" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Enter Description</td>
                        <td>
                            <asp:TextBox ID="planDescription" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Is Popular Plan</td>
                        <td>
                            <asp:CheckBox ID="planIsPopular" runat="server" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="addPlanButton" runat="server" Text="Button" OnClick="addPlanButton_Click" /></td>
                    </tr>
                </table>
            </center>
        </div>
    </form>
</body>
</html>
