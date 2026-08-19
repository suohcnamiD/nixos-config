{ config, pkgs, ... }: {

	services.ollama = {
		enable = true;
		package = pkgs.ollama-cuda;
	    loadModels = [ "qwen2.5-coder:1.5b" ];
        openFirewall = false;
	};
	
    environment.systemPackages = with pkgs; [ ollama aider-chat ];
}
