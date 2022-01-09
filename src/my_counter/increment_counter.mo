import Text "mo:base/Text";
import Nat "mo:base/Nat";
actor Counter {

    public type HeaderField = (Text,Text);
    public type HttpRequest = {
        url:Text;
        method:Text;
        body:[Nat8];
        headers:[HeaderField];
    };
    public type HttpResponse = {
        body : Blob;
        headers: [HeaderField];
        streaming_strategy: ?StreamingStrategy;
        status_code: Nat16;
    };

    public type key = Text;
    public type Path = Text;
    public type ChunkId = Nat;
    public type SetAssetContentArguments = {
        key : key;
        sha256 : ?[Nat8];
        chunk_ids : [ChunkId];
        content_encoding : Text;
    };
    public type SteamingCallbackHttpResponse = {
        token : ?StreamingCallbackToken;
        body : [Nat8];
    };

    public type StreamingCallbackToken = {
        key : Text;
        sha256 : ?[Nat8];
        index : Nat;
        content_encoding : Text;
    };
    public type StreamingStrategy = {
        #callback : {
            token : StreamingCallbackToken;
            callback : shared query StreamingCallbackToken -> async SteamingCallbackHttpResponse;
        };
    };

    stable var currentValue : Nat = 0;

    public func increment() : async(){
        currentValue +=1;
    };

    public query func get() : async Nat {
        currentValue;
    };

    public func set(n : Nat): async(){
        currentValue:=n;
    };
    public shared query func http_request(request : HttpRequest): async HttpResponse{

        {
            body = Text.encodeUtf8("<html><head><meta charset='UTF-8'/></head><body><h1> currentCount:" # Nat.toText(currentValue) #"</h1>前端静态资源调用演示：<a href='https://j7kqj-7aaaa-aaaai-abfda-cai.ic0.app/' target='_blank' > my_counts_assets</a></body></html>");
            headers = [];
            streaming_strategy = null;
            status_code = 200;
        }
    }
    // public func print(): async {
    //     Text.toNat('xxx');
    // }
}