# Single_Cell_Somatic_Mutation_Caller Developer Readme


## Running this app with additional computational resources

This app has the following entry points:

* main

When running this app, you can override the instance type to be used by
providing the ``systemRequirements`` field to ```/applet-XXXX/run``` or
```/app-XXXX/run```, as follows:

    {
      systemRequirements: {
        "main": {"instanceType": "mem2_hdd2_x2"}
      },
      [...]
    }

See https://documentation.dnanexus.com/developer/api/running-analyses/instance-types in the API documentation for more information about the available instance types.
