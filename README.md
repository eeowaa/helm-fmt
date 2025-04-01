# Helm Fmt

String formatting library chart for Helm. Provides templates to convert strings
to standard formats such as those [required by Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/).

## Installation

To use this library in a Helm chart, perform the following steps from within
your local chart directory, adjusting paths and versions as necessary:

1. Clone the git repositories for Helm Fmt and [its dependencies](Chart.yaml):

    ```sh
    git clone --depth 1 -b 0.1.0 https://github.com/eeowaa/helm-fmt.git ../helm-fmt
    git clone --depth 1 -b 0.1.0 https://github.com/eeowaa/helm-rx.git ../helm-rx
    ```

2. Add a library chart dependency to your chart's `Chart.yaml`:

    ```yaml
    dependencies:
      - name: fmt
        version: 0.1.0
        repository: file://../helm-fmt
    ```

3. Copy the Helm Fmt library chart into your `charts/` directory:

    ```sh
    helm dependency update
    ```

For more information about Helm dependencies and library charts, see the
official Helm documentation:

- <https://helm.sh/docs/helm/helm_dependency/>
- <https://helm.sh/docs/topics/library_charts/>

## Usage

This chart provides the following templates:

- `fmt.dns.subdomain`: Converts a string to a valid RFC 1123 DNS subdomain name.
- `fmt.dns.label.rfc1123`: Converts a string to a valid RFC 1123 DNS label name.
- `fmt.dns.label.rfc1035`: Converts a string to a valid RFC 1035 DNS label name.
- `fmt.k8s.name.safe`: Converts a string to a valid format for all Kubernetes object names.

The expected context of each template is a string value. The following example
demonstrates the use of `fmt.dns.label.rfc1035` to [define a Service](https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service)
with a valid name based on `.Chart.Name`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "fmt.dns.label.rfc1035" .Chart.Name }}
spec:
  selector:
    app.kubernetes.io/name: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
```

Note that Helm Fmt depends on the [Helm Rx library chart](https://github.com/eeowaa/helm-rx.git)
to perform string manipulations.
