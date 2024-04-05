#include "hbhttp.ch"

PROCEDURE Main()
    LOCAL oHttp := THttp():New()

    // Define a porta que o servidor irá escutar
    oHttp:setPort(1083)

    // Define a função de callback para manipular as requisições HTTP recebidas
    oHttp:setRequestHandler( {|oReq, oRes| handleRequest(oReq, oRes) } )

    // Inicia o servidor
    oHttp:start()

    // Aguarda uma tecla ser pressionada para encerrar o servidor
    ? "Servidor HTTP escutando na porta 1083. Pressione qualquer tecla para encerrar."
    Read()

    // Encerra o servidor
    oHttp:stop()
RETURN

// Função para manipular as requisições HTTP recebidas
FUNCTION handleRequest(oReq, oRes)
    LOCAL cPath := oReq:getPath()  // Obtém o caminho da requisição

    // Define a resposta com base no caminho da requisição
    SWITCH cPath
        CASE "/":
            // Se a requisição for para a raiz, envia uma resposta simples
            oRes:writeHead(200, { "Content-Type", "text/plain" })
            oRes:end("Servidor HTTP em execução!")
        CASE "/hello":
            // Se a requisição for para /hello, envia uma mensagem de saudação
            oRes:writeHead(200, { "Content-Type", "text/plain" })
            oRes:end("Olá, mundo!")
        CASE "/time":
            // Se a requisição for para /time, envia a hora atual
            oRes:writeHead(200, { "Content-Type", "text/plain" })
            oRes:end("Hora atual: " + TIME())
        CASE "/shutdown":
            // Se a requisição for para /shutdown, encerra o servidor
            oRes:writeHead(200, { "Content-Type", "text/plain" })
            oRes:end("Servidor sendo encerrado...")
            QUIT
        OTHERWISE
            // Se o caminho não for encontrado, envia uma resposta 404
            oRes:writeHead(404, { "Content-Type", "text/plain" })
            oRes:end("404 - Não encontrado")
    END SWITCH
RETURN
