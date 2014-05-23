<r:require module="typehead" />

<div class="homeWrapper">
      <g:form controller="employee" action="list" id="ajaxForm" method="POST">
            <div class="search">
                  <g:if test="${params.email}">
                        <div style="margin-bottom:10px;color: #ff0000;text-align: center; "><p>" ${params.email} " could not be found. Please enter an existing email or FirstName.</p></div>
                  </g:if>
                  <div class="searchFild">
                      <g:select id="email" name="email" data-provide="typeahead"  data-items="4" noSelection="['':'']" from="${com.deerwalk.dss.Employee.list()}" optionKey="email" optionValue="searchCrit"  required="" class=" span3 dropdown-search" placeholder="Employee name or email"/>
                      %{--<input type="text" name="email" class="span3 dropdown-search" id="search" data-provide="typeahead" value="" placeholder="Search Employee"/>--}%
                        %{--<g:select name="email" from="" class="span3 dropdown-search" id="search" data-provide="typeahead" value="" placeholder="Search Employee"/>--}%
                        <input id="searchIcon"  type="button" style="background:url(${resource(dir: 'images', file: 'searchIcon.png')}) top left no-repeat;"/>
                  </div>

            </div>
      </g:form>
</div>
<script language ="javascript" type = "text/javascript" >
      $( "#searchIcon" ).click(function() {
            $( "form:first" ).submit();
      });
      $(document).ready(function(){
          $('#email').typeahead()
      })</script>
%{--<script>
      $(document).ready(function(){
            $("#search").autoComplete
            $("#search").typeahead({
                  source: function(query, process){
                        return $.get("${createLink(controller: "dashBoard",action: "ajaxSearch")}", { query: query }, function (data) {
                          var d = parseJsonData(data);
                              return process(d);
                        });
                  }
            });
      });
      function parseJsonData(data){

            alert (data);
            for(var i=0; i<=data.length; i++){
                  alert(data[i]);
                  if (data[i] =='[' ||data[i] ==']' ||data[i] =='\''){
                        var index = data.indexOf(data[i]);
                        //alert(index)
                        /*if (index != -1) {
                              data.splice(index, 1);
                        }*/
                  }
            }
//            var s = data.replace("]","").replace("[","");
//            var d = s.split(",");
//            for(var i=0; i<= d.length; i++){
//                  d[i]=d[i].replace("\\'","")
//            }
            alert('data final -- '+data)
            return data;
      }
</script>--}%
