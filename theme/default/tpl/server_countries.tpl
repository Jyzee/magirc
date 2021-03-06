<h1>{t 1=$target}Current Country Statistics for %1{/t}</h1>
<div id="chart-countries" style="min-width: 700px; height: 400px; margin: 0 auto"></div>

<table id="tbl_countries" class="display">
	<thead>
		<tr><th>{t}Country{/t}</th><th>{t}Count{/t}</th></tr>
	</thead>
	<tbody>
		<tr><td colspan="2">{t}Loading{/t}...</td></tr>
	</tbody>
</table>

{jsmin}
<script type="text/javascript">
{literal}
$(document).ready(function() {
    $.getJSON('rest/service.php/servers/'+target+'/countries/percent', function(data) {
		new Highcharts.Chart({
			chart: { renderTo: 'chart-countries' },
			tooltip: {
				formatter: function() {
					return '<b>'+ this.point.name +'<\/b>: '+ this.y +' %'+' (' + this.point.count +')';
				}
			},
			series: [{
				type: 'pie',
				name: mLang.CountryStatistics,
				data: data,
				dataLabels: {
					formatter: function() {
						return '<b>'+ this.point.name +'<\/b>: '+ this.y +' %'+' (' + this.point.count +')';
					}
				}
			}]
		});
	});
	$('#tbl_countries').dataTable({
		"iDisplayLength": 10,
		"aaSorting": [[ 1, "desc" ]],
		"sAjaxSource": "rest/service.php/servers/"+target+"/countries?format=datatables",
		"aoColumns": [
			{ "mDataProp": "country", "fnRender": function(oObj) {
				return getCountryFlag(oObj.aData) + ' ' + oObj.aData['country'];
			} },
			{ "mDataProp": "count" }
		]
	});
});
{/literal}
</script>
{/jsmin}