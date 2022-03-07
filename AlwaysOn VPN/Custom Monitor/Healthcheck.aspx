<%@ Page Language="C#" %>
<!DOCTYPE html>

<script runat="server">
    public int FailureCnt = 0;

    public void ServiceHealth(string ServiceName)
    {
        try
        {

            System.ServiceProcess.ServiceController sc = new System.ServiceProcess.ServiceController(ServiceName);
            Response.Write("<br>Checking Service Status: " + ServiceName);
            switch (sc.Status)
            {
                case System.ServiceProcess.ServiceControllerStatus.Running:
                    Response.Write(" - <font color='green'>Pass</font>" + Environment.NewLine);
                    break;
                default:
                    Response.Write(" - <font color='red'>FAIL</font>" + Environment.NewLine);
                    FailureCnt = FailureCnt + 1;
                    break;
            }
        }
        catch
        {
            Response.Write(" - <font color='red'>FAIL - Service Missing</font>" + Environment.NewLine);
            FailureCnt = FailureCnt + 1;
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Service Health</title>
</head>
<body>
    <%
        ServiceHealth("Routing and Remote Access");
        if (FailureCnt == 0 )
        {
            Response.Write("<font color='green'><br>Server OK!</font>");
        }
        else
        {
            Response.Status = "202 Accepted";
            Response.Write("<font color='red'><br>Server Error</font>");
        }
    %>
</body>
</html>