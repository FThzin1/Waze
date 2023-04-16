local cfg = {}

cfg.groups = {
	["dev"] = {
		_config = {
			title = "DEV",
			gtype = "gerente"
		},
		"dev.permissao",
		"ceo.permissao",
		"admin.permissao",
		"mod.permissao",
		"suporte.permissao",
		"aprovadorwl.permissao",
		"chatadm.permissao",
		"chamadoadmin.permissao",
		"blocktp.permissao",
		"dv.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"spec.permissao",
		"player.spec",      
		"player.wall",      
		"mqcu.permissao"    
	},
	["ceo"] = {
		_config = {
			title = "CEO",
			gtype = "gerente"
		},
		"ceo.permissao",
		"admin.permissao",
		"mod.permissao",
		"suporte.permissao",
		"aprovadorwl.permissao",
		"chatadm.permissao",
		"dv.permissao",
		"blocktp.permissao",
		"chamadoadmin.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"spec.permissao",
		"player.secret",
		"player.spec",        
		"player.wall",        
		"mqcu.permissao"    
	},
	["admin"] = {
		_config = {
			title = "Administrador",
			gtype = "gerente"
		},
		"admin.permissao",
		"mod.permissao",
		"suporte.permissao",
		"aprovadorwl.permissao",
		"chatadm.permissao",
		"blocktp.permissao",
		"dv.permissao",
		"chamadoadmin.permissao",
		"adm2.permissao",
		"player.blips",
		"spec.permissao",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"player.spec",        
		"player.wall",        
		"mqcu.permissao"   
	},
	["mod"] = {
		_config = {
			title = "Moderador",
			gtype = "gerente"
		},
		"mod.permissao",
		"suporte.permissao",
		"aprovadorwl.permissao",
		"chatadm.permissao",
		"dv.permissao",
		"spec.permissao",
		"chamadoadmin.permissao",
		"mod2.permissao",
		"player.blips",
		"player.noclip",
		"player.spec",
		"player.teleport",
		"player.secret",
		"player.wall"   
	},
	["suporte"] = {
		_config = {
			title = "Suporte",
			gtype = "gerente"
		},
		"suporte.permissao",
		"aprovadorwl.permissao",
		"chatadm.permissao",
		"dv.permissao",
		"sup2.permissao",
		"chamadoadmin.permissao",
		"player.blips",
		"spec.permissao",
		"player.spec",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"player.wall"   
	},
	["helper"] = {
		_config = {
			title = "Helper",
			gtype = "gerente"
		},
		"suporte.permissao",
		"aprovadorwl.permissao",
		"chatadm.permissao",
		"dv.permissao",
		"helper.permissao",
		"chamadoadmin.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret",
		"player.wall"   
	},
	["aprovador"] = {
		_config = {
			title = "Aprovador",
			gtype = "gerente"
		},
		"aprovadorwl.permissao",
		"apv2.permissao",
		"player.blips",
		"player.noclip",
		"player.teleport",
		"player.secret"
		
	},
	["streamer"] = {
		_config = {
			title = "Streamer"
		},
		"streamer.permissao",
		"booster.permissao"
	},
	["wazepass"] = {
		_config = {
			title = "Waze Pass"
		},
		"player.noclip",
		"player.teleport",
		"wazepass.permissao"
	},
	["influencer"] = {
		_config = {
			title = "Influencer"
		},
		"influencer.permissao",
		"player.noclip",
		"player.teleport",
		"streamer.permissao",
		"booster.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Setagens Vips ]----------------------------------------------------------
	-----------------------------------------------------------------------------
	["wazeelite"] = {
		_config = {
			title = "waze Elite",
			gtype = "vip"
		},
		"wazeelite.permissao",
		"mochila.permissao",
		"cor.permissao"
	},
	["waze"] = {
		_config = {
			title = "waze",
			gtype = "vip"
		},
		"waze.permissao",
		"cor.permissao",
		"mochila.permissao"
	},
	["Booster"] = {
		_config = {
			title = "Booster"
		},
		"booster.permissao"
	},
	["rental"] = {
		_config = {
			title = "Rental"
		},
		"rental.permissao"
	},
	["verificado"] = {
		_config = {
			title = "Verificado"
		},
		"verificado.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Departamento de Justiça ]------------------------------------------------
	-----------------------------------------------------------------------------
	["juiz"] = {
		_config = {
			title = "Juiz(a)",
			gtype = "job"
		},
		"juiz.permissao",
	},
	["advogado"] = {
		_config = {
			title = "Advogado(a)",
			gtype = "job"
		},
		"advogado.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Empregos Cidade ]--------------------------------------------------------
	-----------------------------------------------------------------------------
	["Css"] = {
		_config = {
			title = "Concessionária",
			gtype = "job"
		},
		"vendedor.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Departamento de Policia ]------------------------------------------------
	-----------------------------------------------------------------------------
	["policia"] = {
		_config = {
			title = "Policia",
			gtype = "job"
		},
		"policia.permissao",
		"chatpolicia.permissao",
		"policiaatirando.permissao",
		"policiasaque.permissao",
		"policiadroga.permissao",
		"carpolicia.permissao",
		"player.blips"
	},
	["policiaacao"] = {
		_config = {
			title = "Policia Ação",
			gtype = "job"
		},
		"policiaacao.permissao",
		"mochila.permissao",
		"chatpolicia.permissao",
		"policiadroga.permissao",
		"carpolicia.permissao",
		"policiasaque.permissao",
		"player.blips"
	},
	["paisanapolicia"] = {
		_config = {
			title = "Paisana Policia",
			gtype = "job"
		},
		"paisanapolicia.permissao",
		"policiasaque.permissao",
		"player.blips"
	},
	-----------------------------------------------------------------------------
	--[	Departamento de Policia ]------------------------------------------------
	-----------------------------------------------------------------------------
	["policianorte"] = {
		_config = {
			title = "Polícia",
			gtype = "job"
		},
		"policianorte.permissao",
		"disparo.permissao",
		"roubos.permissao",
		"policiasaque.permissao",
		"player.blips"
	},
	["paisanapolicianorte"] = {
		_config = {
			title = "Paisana Polícia",
			gtype = "job"
		},
		"paisanapolicianorte.permissao",
		"policiasaque.permissao",
		"player.blips"
	},
	-----------------------------------------------------------------------------
	--[	Departamento Médico ]----------------------------------------------------
	-----------------------------------------------------------------------------
	["medico"] = {
		_config = {
			title = "Medico",
			gtype = "job"
		},
		"medico.permissao",
		"player.blips"
	}, 
	["paisanamedico"] = {
		_config = {
			title = "Paisana Medico",
			gtype = "job"
		},
		"paisanamedico.permissao",
		"player.blips"
	},
	-----------------------------------------------------------------------------
	--[	Departamento Médico ]----------------------------------------------------
	-----------------------------------------------------------------------------
	["mediconorte"] = {
		_config = {
			title = "Medíco",
			gtype = "job"
		},
		"mediconorte.permissao",
		"player.blips"
	}, 
	["paisanamediconorte"] = {
		_config = {
			title = "Paisana Medíco",
			gtype = "job"
		},
		"paisanamediconorte.permissao",
		"player.blips"
	},
	-----------------------------------------------------------------------------
	--[	Mecânico e Bennys ]------------------------------------------------------
	-----------------------------------------------------------------------------
	["mecanico"] = {
		_config = {
			title = "Mecanico",
			gtype = "job"
		},
		"mecanico.permissao",
		"player.blips"
	},
	["paisanamecanico"] = {
		_config = {
			title = "Mecanico de folga",
			gtype = "job"
		},
		"paisanamecanico.permissao",
		"player.blips"
	},
	-----------------------------------------------------------------------------
	--[	Bennys ]------------------------------------------------------
	-----------------------------------------------------------------------------
	["bennys"] = {
		_config = {
			title = "Bennys",
			gtype = "job"
		},
		"bennys.permissao",
		"player.blips"
	},
	["paisanabennys"] = {
		_config = {
			title = "Bennys de folga",
			gtype = "job"
		},
		"paisanabennys.permissao",
		"player.blips"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e venda de drogas ]------------------------------
	-----------------------------------------------------------------------------
	["ballas"] = {
		_config = {
			title = "Ballas",
			gtype = "job",
		},
		"ballas.permissao",
		"drogas.permissao"
	},

	["groove"] = {
		_config = {
			title = "Grove",
			gtype = "job",
		},
		"grove.permissao",
		"drogas.permissao"
	},

	["vagos"] = {
		_config = {
			title = "Vagos",
			gtype = "job",
		},
		"vagos.permissao",
		"drogas.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e venda de armas ]-------------------------------
	-----------------------------------------------------------------------------
	["crips"] = {
		_config = {
			title = "Crips",
			gtype = "job",
		},
		"crips.permissao",
		"armas.permissao"
	},

	["bloods"] = {
		_config = {
			title = "Bloods",
			gtype = "job",
		},
		"bloods.permissao",
		"armas.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e venda de munições ]----------------------------
	-----------------------------------------------------------------------------
	["bratva"] = {
		_config = {
			title = "Máfia Bratva",
			gtype = "job",
		},
		"bratva.permissao",
		"municao.permissao"
	},

	["siciliana"] = {
		_config = {
			title = "Máfia Siciliana",
			gtype = "job",
		},
		"siciliana.permissao",
		"municao.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de lavagem ]------------------------------------------------------
	-----------------------------------------------------------------------------
	["lifeinvader"] = {
		_config = {
			title = "Life Invader",
			gtype = "job",
		},
		"lifeinvader.permissao",
		"lavagem.permissao"
	},
	["bahamas"] = {
		_config = {
			title = "Bahamas",
			gtype = "job",
		},
		"bahamas.permissao",
		"lavagem.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de desmanche DESATIVADOS]-----------------------------------------------
	-----------------------------------------------------------------------------
--[[ 	["hells"] = {
		_config = {
			title = "Hell Angels",
			gtype = "job",
		},
		"hells.permissao",
		"desmanche.permissao"
	},

	["warlocks"] = {
		_config = {
			title = "Warlocks",
			gtype = "job",
		},
		"warlocks.permissao",
		"desmanche.permissao"
	}, ]]
	-----------------------------------------------------------------------------
	--[	Scripted ]-----------------------------------------------
	-----------------------------------------------------------------------------
	["scripted"] = {
		_config = {
			title = "Scripted",
			gtype = "job",
		},
		"scripted.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Emprego secundario ]------------------------------------------------------
	-----------------------------------------------------------------------------
	["id"] = {
		_config = {
			title = "Monster",
			gtype = "jobdois",
		},
		"id.permissao"
	},
	["policiaftu"] = {
		_config = {
			title = "DEPOL",
			gtype = "jobdois"
		},
		"policiaftu.permissao",
		"dv.permissao"
	},
	["gangunit"] = {
		_config = {
			title = "Gang Unit",
			gtype = "jobdois"
		},
		"gangunit.permissao",
		"dv.permissao"
	},
	["diretor"] = {
		_config = {
			title = "Diretor(a)",
			gtype = "jobdois"
		},
		"diretor.permissao"
	},

	["chefemec"] = {
		_config = {
			title = "Mêcanico Chefe",
			gtype = "jobdois"
		},
		"mecanico.permissao"
	}
}

cfg.users = {
	[0] = { "dev" },
	[1] = { "dev" },
	[2] = { "dev" },
}

cfg.selectors = {}

return cfg