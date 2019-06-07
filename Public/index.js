document.addEventListener('DOMContentLoaded', function() {
	$(".demo-form").keyup(function() {
		
		// Enable/Disable generate button
		let link = $('#inputLink').val();
		let bundle = $('#inputBundle').val();
		let title = $('#inputTitle').val();

        if (isURL(link) && bundle && title) {
			$(".generate-btn").removeAttr('disabled');
		} else {
			$(".generate-btn").prop('disabled', true);
		}
		
		// Generate button clicked
		$(".generate-btn").off().click(function(e) {
			e.preventDefault()
			
			let link = $('#inputLink').val();
			let bundle = $('#inputBundle').val();
			let title = $('#inputTitle').val();
			
			// Call API
			$.getJSON(`request?link=${link}&bundle=${bundle}&title=${title}`, function(response) {
				$(".completion-text").removeClass("hidden");
				$(".completion-url").attr("href", `plists/${response.uuid}.plist`)
				$(".completion-itms-url").attr("href", `itms-services://?action=download-manifest&url=https://itms-plist-helper.vapor.cloud/plists/${response.uuid}.plist`)
			});
				
		});
		
	});
	
	function isURL(str) {
		return /^(?:\w+:)?\/\/([^\s\.]+\.\S{2}|localhost[\:?\d]*)\S*$/.test(str); 
	}
})
