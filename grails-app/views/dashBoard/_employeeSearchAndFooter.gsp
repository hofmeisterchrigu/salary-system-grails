<div class="homeWrapper">
	<div class="search">
		<div class="searchFild">
			<input type="text" class="span3" id="search" data-provide="typeahead" placeholder="Search Employee with Employee Email"/>
                  <input type="button" style="background:url(${resource(dir: 'images', file: 'searchIcon.png')}) top left no-repeat;"/>
		</div>

	</div>
</div>
<script>
      $(document).ready(function(){
      $("#search").typeahead({
            source : ["aa","bb","cc"]
            %{--source: function(query, process){--}%
                  %{--alert("on process");--}%
                  %{--return $.get("${createLink(controller: "dashBoard",action: "ajaxSearch")}", { query: query }, function (data) {--}%
                        %{--alert("data "+data);--}%
                        %{--var ajaxData = data.split(",");--}%
                        %{--return process(ajaxData);--}%
                  %{--});--}%
            %{--}--}%
      });
      });
</script>