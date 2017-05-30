package kr.or.dgit.haru.util;

import org.springframework.beans.factory.annotation.Autowired;

import com.auth0.jwt.JWT;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;

import kr.or.dgit.haru.domain.AuthDTO;
import kr.or.dgit.haru.service.UserService;

public class HaruTokenService {
	@Autowired
	private UserService uService;
	
	
	public static AuthDTO decodeToAuth(String token){
		DecodedJWT jwt = JWT.decode(token);
		
		Claim uidClaim = jwt.getHeaderClaim("uid");
		Claim upicClaim = jwt.getHeaderClaim("upic");
		Claim uadminClaim = jwt.getHeaderClaim("uadmin");
		
		AuthDTO auth = new AuthDTO();
		auth.setUid(uidClaim.asString());
		if(!upicClaim.isNull()){
			auth.setUpic(upicClaim.asString());
		}
		auth.setUadmin(uadminClaim.asBoolean());
		
		
		return auth;		
	}
}
