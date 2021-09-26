export const generateEmail = (domain: string, date: string): string => `
<!DOCTYPE HTML> 

<html>

<head>


<style>
@media only screen and (max-width: 600px) {
		.main {
			width: 320px !important;
		}

		.top-image {
			width: 100% !important;
		}
		.inside-footer {
			width: 320px !important;
		}
		table[class="contenttable"] { 
            width: 320px !important;
            text-align: left !important;
        }
        td[class="force-col"] {
	        display: block !important;
	    }
	     td[class="rm-col"] {
	        display: none !important;
	    }
		.mt {
			margin-top: 15px !important;
		}
		*[class].width300 {width: 255px !important;}
		*[class].block {display:block !important;}
		*[class].blockcol {display:none !important;}
		.emailButton{
            width: 100% !important;
        }

        .emailButton a {
            display:block !important;
            font-size:18px !important;
        }

	}

</style>

</head>

  <body link="#00a5b5" vlink="#00a5b5" alink="#00a5b5">

<table class=" main contenttable" align="center" style="font-weight: normal;border-collapse: collapse;border: 0;margin-left: auto;margin-right: auto;padding: 0;font-family: Arial, sans-serif;color: #555559;background-color: white;font-size: 16px;line-height: 26px;width: 600px;">
		<tr>
			<td class="border" style="border-collapse: collapse;border: 1px solid #eeeff0;margin: 0;padding: 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 26px;">
				<table style="font-weight: normal;border-collapse: collapse;border: 0;margin: 0;padding: 0;font-family: Arial, sans-serif;">
					<tr>
						<td colspan="4" valign="top" class="image-section" style="border-collapse: collapse;border: 0;margin: 0;padding: 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 26px;background-color: #fff;border-bottom: 4px solid #EC7100">
							
						</td>
					</tr>
					<tr>
						<td valign="top" class="side title" style="border-collapse: collapse;border: 0;margin: 0;padding: 20px;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 26px;vertical-align: top;background-color: white;border-top: none;">
							<table style="font-weight: normal;border-collapse: collapse;border: 0;margin: 0;padding: 0;font-family: Arial, sans-serif;">
								<tr>
									<td class="head-title" style="border-collapse: collapse;border: 0;margin: 0;padding: 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 28px;line-height: 34px;font-weight: bold; text-align: center;">
										<div class="mktEditable" id="main_title" style="padding: 20px;">
											Obaveštenje o isteku domena 
											
										</div>
									</td>
								</tr>
								<tr>
									
								</tr>
								<tr>
									<td class="top-padding" style="border-collapse: collapse;border: 0;margin: 0;padding: 5px;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 26px;"></td>
								</tr>
								<tr>
									<td class="grey-block" style="border-collapse: collapse;border: 0;margin: 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 26px;background-color: #fff; text-align:center;">
									<div class="mktEditable" id="cta">
									<img class="top-image" src="https://i.imgur.com/zPA9qvf.jpg" width="560"/><br><br>
									
									<i><h2> Poštovani  </h2></i>
									<p>Obaveštavamo Vas da je ${domain} domen istekao, ukoliko želite da obnovite domen molimo Vas odgovorite nam na ovaj mejl... </p>
									<br>
										<strong>Datum isteka:</strong> ${date}<br>
			                            <br>
			                             <a style="color:#ffffff; background-color: #ff8300;  border: 10px solid #ff8300; border-radius: 3px; text-decoration:none;" href="#">Obnovi odmah</a>
									</div>
									</td>
								</tr>
								<tr>
									<td class="top-padding" style="border-collapse: collapse;border: 0;margin: 0;padding: 15px 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 21px;">
										<hr size="1" color="#eeeff0">
									</td>
								</tr>
								<tr>
									
								</tr>
								<tr>
									<td style="border-collapse: collapse;border: 0;margin: 0;padding: 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 24px;">
									 &nbsp;<br>
									</td>
								</tr>
								<tr>
									<td class="text" style="border-collapse: collapse;border: 0;margin: 0;padding: 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 24px;">
									
									</td>
								</tr>

							</table>
						</td>
					</tr>
					<tr>
						<td style="padding:20px; font-family: Arial, sans-serif; -webkit-text-size-adjust: none;" align="center">
							<table>
								<tr>
									<td align="center" style="font-family: Arial, sans-serif; -webkit-text-size-adjust: none; font-size: 16px;">
										<a style="color: #ff8300;" href="{{system.forwardToFriendLink}}">Prosledi mail</a>
										<br/><span style="font-size:10px; font-family: Arial, sans-serif; -webkit-text-size-adjust: none;" >Molimo Vas, prosledite ovaj mejl kolegama ili kontaktima koji bi bili zainteresovani da prime ovaj mejl.</span>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style="border-collapse: collapse;border: 0;margin: 0;padding: 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 24px; padding: 20px;">
						<div class="mktEditable" id="cta_try">
							<table border="0" cellpadding="0" cellspacing="0" class="mobile" style="font-weight: normal;border-collapse: collapse;border: 0;margin: 0;padding: 0;font-family: Arial, sans-serif;">
							    <tr>
							    	<td class="force-col" valign="top" style="border-collapse: collapse;border: 0;margin: 0;padding: 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 24px;">
							    	
							            <table class="mb mt" style="font-weight: normal;border-collapse: collapse;border: 0;margin: 0;padding: 0;font-family: Arial, sans-serif;margin-bottom: 15px;margin-top: 0;">
							            
							            </table>
							        </td>	
									
							       	
							    </tr>
							</table>
						</div>
						</td>
					</tr>											
					<tr>
						<td valign="top" align="center" style="border-collapse: collapse;border: 0;margin: 0;padding: 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 26px;">
							<table style="font-weight: normal;border-collapse: collapse;border: 0;margin: 0;padding: 0;font-family: Arial, sans-serif;">
								<tr>
									<td align="center" valign="middle" class="social" style="border-collapse: collapse;border: 0;margin: 0;padding: 10px;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 26px;text-align: center;">
										<table style="font-weight: normal;border-collapse: collapse;border: 0;margin: 0;padding: 0;font-family: Arial, sans-serif;">
											<tr>
												<td style="border-collapse: collapse;border: 0;margin: 0;padding: 5px;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 26px;"><a href=""><img src="https://icons.iconarchive.com/icons/yootheme/social-bookmark/512/social-rss-box-orange-icon.png" width="32px"></a></td>
									<td style="border-collapse: collapse;border: 0;margin: 0;padding: 5px;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 26px;"><a href=""><img src="https://www.pinclipart.com/picdir/big/176-1768234_social-media-icons-instagram-circle-clipart.png " width="30px"></a></td>

									

											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr bgcolor="#fff" style="border-top: 4px solid #EC7100;">
						<td valign="top" class="footer" style="border-collapse: collapse;border: 0;margin: 0;padding: 0;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 16px;line-height: 26px;background: #fff;text-align: center;">
							<table style="font-weight: normal;border-collapse: collapse;border: 0;margin: 0;padding: 0;font-family: Arial, sans-serif;">
								<tr>
									<td class="inside-footer" align="center" valign="middle" style="border-collapse: collapse;border: 0;margin: 0;padding: 20px;-webkit-text-size-adjust: none;color: #555559;font-family: Arial, sans-serif;font-size: 12px;line-height: 16px;vertical-align: middle;text-align: center;width: 580px;">
<div id="address" class="mktEditable">
										<b>Priority Lookup</b><br>  Srbija <br> Nis, 18000<br>
                            <a style="color: #ff8300;" href="mailto:whois-madjije@prioritysoft.io">Kontaktirajte nas</a>
</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
  </body>




</html>
`;