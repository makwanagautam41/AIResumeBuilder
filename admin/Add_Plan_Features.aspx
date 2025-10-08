<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_Plan_Features.aspx.cs" Inherits="airesumebuilder.admin.Add_Plan_Features" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Plan Features</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <center>
                <table border="1" cellpadding="5">
                    <tr>
                        <td>Select Plan</td>
                        <td>
                            <asp:DropDownList ID="ddlPlans" runat="server" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlPlans_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Enter Plan Feature</td>
                        <td>
                            <asp:TextBox ID="feature_name" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Is Included?</td>
                        <td>
                            <asp:CheckBox ID="chkIsIncluded" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="add_feature" runat="server" Text="Add Feature" OnClick="add_feature_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
                        </td>
                    </tr>
                </table>

                <br />

                <asp:GridView ID="gvFeatures" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="FeatureID"
                    OnRowDeleting="gvFeatures_RowDeleting"
                    BorderColor="Black" BorderWidth="1">
                    <Columns>
                        <asp:BoundField DataField="FeatureID" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="FeatureName" HeaderText="Feature Name" />
                        <asp:CheckBoxField DataField="IsIncluded" HeaderText="Included" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>

            </center>
        </div>
    </form>
</body>
</html>
