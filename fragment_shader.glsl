#version 330 core

uniform sampler2D tex;
uniform vec3 lightPos;

out vec4 outColor;

in vec2 textureCoordinate;
in vec3 fragmentPosition;
in vec3 normalCoords;
in vec3 viewCoords;

void main(){
    vec3 lightColor = vec3(1, 1, 1);
    //vec3 lightPos = vec3(5, 5, -10);

    // ambient
    float ambientStrength = 0.1;
    vec3 ambient = ambientStrength * lightColor;
   
    // diffuse 
    vec3 norm = normalize(normalCoords);
    vec3 lightDir = normalize(lightPos - fragmentPosition);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    
    // specular
    float specularStrength = 0.5;
    vec3 viewDir = normalize(viewCoords - fragmentPosition);
    vec3 reflectDir = reflect(-lightDir, norm);  
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
    vec3 specular = specularStrength * spec * lightColor;  

    vec4 col = texture(tex, textureCoordinate);
    vec3 outc = (ambient + diffuse + specular) * col.xyz;  
    outColor = vec4(outc, col.a);
}