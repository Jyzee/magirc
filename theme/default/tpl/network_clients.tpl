<h1>Current Client Statistics</h1>
<div id="chart-clients" style="min-width: 700px; height: 400px; margin: 0 auto"></div>

<table id="tbl_clients" class="display">
	<thead>
		<tr><th>Client</th><th>Count</th></tr>
	</thead>
	<tbody>
		<tr><td colspan="2">Loading...</td></tr>
	</tbody>
</table>

{jsmin}
<script type="text/javascript">
{literal}
$(document).ready(function() {
    $.getJSON('rest/denora.php/clients/percent', function(data) {
        new Highcharts.Chart({
			chart: { renderTo: 'chart-clients' },
			tooltip: {
				formatter: function() {
					return '<b>'+ this.point.name +'<\/b>: '+ Math.round(this.percentage * 100) / 100 +' %';
				}
			},
			series: [{ type: 'pie', name: 'Client Statistics', data: data }]
		});
	});
	$('#tbl_clients').dataTable({
		"iDisplayLength": 10,
		"aaSorting": [[ 1, "desc" ]],
		"sAjaxSource": "rest/denora.php/clients?format=datatables",
		"aoColumns": [
			{ "mDataProp": "client", "fnRender": function (oObj) {
				return oObj.aData['client'] ? oObj.aData['client'] : 'Unknown';
			} },
			{ "mDataProp": "count" }
		]
	});
});
{/literal}
</script>
{/jsmin}