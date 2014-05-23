<html>
<head>
      <meta name="layout" content="bootstrap">
      <title><g:message code="springSecurity.login.title"/></title>
</head>

<body>
<div class="container-fluid" style="margin-top: 40px">
      <div class="footer" style="margin:0 auto;float:none;">
            <h1 style="font-size: 32px !important; color: #777777;">Access Denied!</h1>
            <h2 style="font-size: 20px !important; color: #777777;"><g:message code="springSecurity.denied.message" /></h2>
            <br>
            %{--<div class="controls controls-row">
                  <a href="${createLink(uri: '/')}" class="btn btn-primary">
                        <i class="icon-chevron-left icon-white"></i>Back to Home
                  </a>
                  <a href="${createLink(uri: '/logout/index')}" class="btn btn-success">
                        <i class="icon-user icon-white"></i>Login
                  </a>
            </div>--}%
      </div>
</div>
</body>
</html>