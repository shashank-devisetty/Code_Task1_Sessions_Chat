<%-- 
    Document   : sessionid
    Created on : Jan 17, 2017, 3:02:59 PM
    Author     : shashank
--%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ServletContext sco = getServletConfig().getServletContext(); 
    String id = (String)sco.getAttribute("id");
    id = request.getParameter("id");
    if(id == null)
    {
        id = request.getParameter("from");
    }
    session.setAttribute("UserId", id);
    String sid =  session.getId() ;
%>
<!DOCTYPE html>
<html>
    <head>
        <link rel = "stylesheet" type = "text/css" href = "ses2.css">
    </head>
    <body>
        <center>
            <div>
                <p align = 'center'>
                    Hello, User <%= session.getAttribute( "UserId" ) %>. Here is your Chat History!!
                </p>
                <p id = 'demo'>
                    <%@page import="java.io.*"%>
                    <%@ page language="java" import="java.util.*" errorPage="" %>
                    <%!
                        public static HashMap<String, HashMap<String, String>> outermessage = new HashMap<String, HashMap<String, String>>();
                    %>
                    <%
                        String to = request.getParameter("to");
                        session.setAttribute("to_id", to);
                        String from = request.getParameter("from");
                        session.setAttribute("from_id", from);
                        String msg = request.getParameter("msg");
                        session.setAttribute("message", msg);
                        outermessage.put(to,new HashMap<String, String>());
                        outermessage.get(to).put(from, msg);
                        for(String name : outermessage.keySet())
                        {
                            
                            for(String key : outermessage.get(name).keySet() )
                            {
                                if(name != null || key != null)
                                    out.print(key + " -->> " + name + " : " + outermessage.get(name).get(key) + "<br>");
                            }
                            
                        }
                    %>
                </p>
            </div><br><br>
        </center>
    </body>
</html>

<%@ page language="java" import="java.util.*" errorPage="" %>
<%@ page language="java" import = "javax.servlet.*" %>
<%    
    ServletContext sc = getServletConfig().getServletContext(); 
    HashMap<String,String> users = (HashMap<String,String>)sc.getAttribute("users");
    if (users == null) 
        users = new HashMap();
    else
    {
        for(String name : users.keySet())
        {
            if((name == id && users.get(name) != sid))
            {
                response.sendRedirect("index.html");
                //Same User Id in different sessions or Different users in same sessions - Both are not permitted.
                
            }
        }
    }
    users.put(id, sid);
    sc.setAttribute("users", users);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel = 'stylesheet' type = 'text/css' href = 'ses.css'>
        <title>Session Page</title>
    </head>
    <body  background = "c1.jpg">
        <center>
            <table id = 'mytable'>
                <caption>
                    <b>Available Sessions</b>
                </caption>
                <tr>
                    <th>User Id</th>
                    <th>Session Id</th>
                </tr>
                <%
                    for(String name : users.keySet())
                    { 
                        out.print("<tr><td>");
                        out.print(name + "</td><td>" + users.get(name));
                        out.print("</td></tr>");
                    }
                %>
            </table>
            <input type="button" value="REFRESH" onclick="refer()">
        </center>
        <br><br>
        <form>
            From User Id: &nbsp;&nbsp;&nbsp;
            <input type ="text" name = "from" readonly = "readonly" value = "<% out.print(id); %>">
            &nbsp;&nbsp;&nbsp;
            To User Id: &nbsp;&nbsp;&nbsp;
            <input type ="text" name = "to" required>
            &nbsp;&nbsp;&nbsp;
            Message to be sent: &nbsp;&nbsp;&nbsp;
            <input type ="text" name = "msg" required>
            &nbsp;&nbsp;&nbsp;
            <input type = "submit" value = "Send message and View Chat History">
        </form>
    </body>
    <script language="javascript">
      /*$("#submit").click(function() {
        $.ajax({
            url: 'sessionid.jsp',
            type: 'POST',
            data: {
            },
            success: function(data) {
                alert('Update Success');
            },
            failure: function(data) {
                alert('Update Failed');
            }
        });
    )};*/
        function refer() 
        {
            location.reload(true);
        }
    </script>
</html>

