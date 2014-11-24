﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using LyncBillingBase.DataAttributes;

namespace LyncBillingBase.DataModels
{
    [DataSource(Name = "MonitoringServersInfo", SourceType = Enums.DataSourceType.DBTable, AccessType = Enums.DataSoyurceAccessType.SingleSource)]
    public class MonitoringServerInfo
    {
        [IsIDField]
        [DbColumn("id")]
        public int ID { get; set; }

        [DbColumn("instanceHostName")]
        public string InstanceHostName { get; set; }

        [DbColumn("instanceName")]
        public string InstanceName { get; set; }

        [DbColumn("databaseName")]
        public string DatabaseName { get; set; }

        [DbColumn("userName")]
        public string Username { get; set; }

        [DbColumn("password")]
        public string Password { get; set; }

        [DbColumn("TelephonySolutionName")]
        public string TelephonySolutionName { get; set; }

        [DbColumn("phoneCallsTable")]
        public string PhoneCallsTable { get; set; }

        [DbColumn("description")]
        public string Description { get; set; }

        [AllowNull]
        [DbColumn("created_at")]
        public DateTime CreatedAt { get; set; } 
    }
}
