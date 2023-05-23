Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5470D56F
	for <lists+linux-s390@lfdr.de>; Tue, 23 May 2023 09:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbjEWHnS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 23 May 2023 03:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjEWHnQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 May 2023 03:43:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7095;
        Tue, 23 May 2023 00:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684827794; x=1716363794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FDh8ACC3NqybdUncTP41VyXkVlM+Ej1aJGcnPn9WAVs=;
  b=P0JGhTqwbZ8tbU6UytYguKmohbE8ZqkPYlAjiTA1JXMq8Kno8N77SWxV
   UGz2OSnWsFqdQPaEL8fGq+hF/aCFmb1/wcXbdZuQdeWvQV59wY7a780nS
   2Ef1FGjLVdUvtEAqhzq2EOv2BTcGNJad2zmYF8KECSUiuIhKovAB43vuf
   Uc8TyL24BOdkXDX7x/YtBZKHEZFF3GX1oWIDrK8Lt6lTOgbZhD5cS7WZu
   vTd78gan6DUqpSMFpvE9Xt9bfD3get9Jrq4jAcW0PUo6xkKow03WYo9OB
   9GTlLihVA4dVCW644sOoYcoC3A9vLugW6g1EoJRQInPissm7xiEqnKgGO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="342623614"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="342623614"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 00:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="1033957862"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="1033957862"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 23 May 2023 00:42:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 00:42:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 00:42:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 00:42:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 00:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWah24pAmVQw8GzPF4Rz65q1VirGahJpaxfsM9RpUk849SarQeC7q0uV9EHuRIoe6q1uG9EYdBQ5/l1I+x0euySfLdD7fwSJ2FKHuFxfWRstI2omy1p3qJW5tOYV+d98LvmvvTO13CQHJClkyUn+wTHRoQGBA6UBh1vbihvwne2x52je+y/Z8JksDHWFRvW4xrHODNI2yfA+mmMecPDbWLLwrL87DR78jrgRSlJQ95q+MRBsaeVj5lE7Gjadx8W5ed8255owSAzRzYnYfToINvIGtgZOag2MoGmyG0yIGWKX5YfL/WbQqj+CWnPTE5xyg7+9KMuVvfA3QHS8g7ECaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDh8ACC3NqybdUncTP41VyXkVlM+Ej1aJGcnPn9WAVs=;
 b=iuyS9BTruZltKUJOu+rqes0d3u4jRxGDcJthTR/P9ZZl51lndk7dO7jrLsifoCQU0dAsEBfdnOxIbMnTwj0bjypDB2Qe6uZDaK4lE4cSpinP0PsZ28gdLO7bFeMv4vmqrWUsLIpEhDWQs0FhC1gTpr1f176Asx2J1bGYLpqUQXrvhRmlBRoFEylYKQ4Hg5AcrwGvtBWg6c+Zqz40/Kf9ahR/2LuJg6l3riO+ARLS63FX1ATNXTCfmn0iiCeiAEm4lnHAPrju9m1Qq3tEUmt6qCsYZgtYw+Bibj52iR+ZNAYZbGcjZsK6vrC3eZd2QARgN2JIayuwwnbil0luHONxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:42:46 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::aefa:6d71:572c:7369]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::aefa:6d71:572c:7369%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 07:42:46 +0000
From:   "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Jiang, Yanting" <yanting.jiang@intel.com>,
        "clegoate@redhat.com" <clegoate@redhat.com>
Subject: RE: [PATCH v11 00/23] Add vfio_device cdev for iommufd support
Thread-Topic: [PATCH v11 00/23] Add vfio_device cdev for iommufd support
Thread-Index: AQHZhZ7RJeFfD1vNyE63npVPZQkwIK9nhwNg
Date:   Tue, 23 May 2023 07:42:45 +0000
Message-ID: <PH7PR11MB6722E2C0F6ACE056751AAED292409@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230513132827.39066-1-yi.l.liu@intel.com>
In-Reply-To: <20230513132827.39066-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|SA0PR11MB4751:EE_
x-ms-office365-filtering-correlation-id: 00301385-ac55-491c-e23f-08db5b614c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWXkXiF7p1WKPbyNzkDWCd87Mk2BAC2ieKFgeBNwe1xapjH9GtB3TZwWO0oNtlpWGFf6zteWt6R8++sLkbS/1vGMw646zxakwxyjyGM4UBNmITl+P+mliijc0eLahetOS2VN6uOUrOwS8nwWHcj4Ood79jxqPGO8thAQCqBAT+2DsCWyxBAeZBkeqldokAExo5T/6+R1Qnz6DHvykTI5kk+HafWJvyawo+HP3YvPmTejl6YhGZRlDMaxRqzvwCdSJaQXOL1jnCJlCpg1vZ0IPohpggzHTrRkHKVg8Hm8xapzsQ67GFjBO443tGPorVUGzCXDEInupoltSCa+FK+YGbwWTvyuQ5xdhI51Qga8vjeSZgTt6hrCno79g7F3+jv1ybVpCpy6I615RZI7+ckeLR5TBO1pSOGwejA/hhsJpZfOUS0GjDlb3MBWAkHqEY9PIiM+ws02jEtCHOb/A3kOyfnTjUpNBzQscg13i0RejzJrMJ+ButerSXCQPTG72GieL0/AAJ7Am66Pc3QXmBE2tGqYToLqw6P7kdu41wSPs/1i/4Y/odYmzubV5ayhEg1fmHY4Ls8NAOcf/xOEM8xxeD9wUE6tsCmd1G9ZlUYs472AcG1klEd5Ixu09HOICbtIx+OZNG+u1xCwYRPumfLLBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(83380400001)(66574015)(71200400001)(8936002)(55016003)(52536014)(7416002)(5660300002)(33656002)(41300700001)(38070700005)(8676002)(2906002)(30864003)(122000001)(45080400002)(478600001)(86362001)(110136005)(54906003)(9686003)(6506007)(82960400001)(38100700002)(186003)(26005)(66446008)(66556008)(66476007)(7696005)(76116006)(316002)(4326008)(6636002)(966005)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk0vd2ZCSHhaMzBZS1Yya3R1c2N6Q08zcnpDNDBEQXBmYnZrbGVoY1RZeE5L?=
 =?utf-8?B?WDE3UTlVZmxnMmZoZ29iS2xBZkVBRVRINzN6OENoRFhMY2E5OE9WbUlJUGlz?=
 =?utf-8?B?VzNoRi9ZQUNVYzhSQjR5dUMzVy8rU0kyN3BhQUpRT1lGWGExYXJnZjJvSXRS?=
 =?utf-8?B?d0taa0JpRHkrbUNhYlFIaE1TUGFOK0NXTitIUzVMOW4xOVZUcG9VOVhwTXhM?=
 =?utf-8?B?cXR1ZEZhSTJkTmhRTWlOZTFzYnlRajRLU1BTc1pVblN2WExURHpUWDlwcEVQ?=
 =?utf-8?B?OGlDOUt5M3lEMjRwdzBlVEp1SDFjVldKKzgvRzVNVjlndTAvTmxmWFFHY0hV?=
 =?utf-8?B?dk50QjhDcWVFdC8wRHBXd1BoTGNlNVdFTXk5Ly9mbWtnY2Qrb2tLWHlVOEFC?=
 =?utf-8?B?Q1FVTUhTUTd1MCtuQWhXUXc5ZUUrc1pDZTRPM2RkTzhYcm9Rei9rS1FEcVl4?=
 =?utf-8?B?WlJzUUlpbEUvdzdCQ01uNms4RzRScXYvT0kvVE81ZHlJcjZQd0F6ZmJFSnQy?=
 =?utf-8?B?dm16a1ZuZlA0V01sdENHZmRDcllvd2NXMDRNK05RUWFIbFJiVnFrVXRRNElP?=
 =?utf-8?B?aEhRZWRCeDZlRDVIbVdCVG51ZG02VkFpV0VacEhMQ0VKa1JsVEFZK3IyL0xi?=
 =?utf-8?B?YmQ0RTF5NVNsN2gxM0EyT09IRE05OW5PemZpK05hdWE5MjlmK2UxQWdMMXdB?=
 =?utf-8?B?cEI0MGRTKzZXUFZRL05HVGtGeUhGZUloVTBjc04vRDc5SWp4N1F2NWYzbkR0?=
 =?utf-8?B?QllEZkM0aHpOUFVlaVFKTFEwRzZaY0YySjNIajhoNG1SVnU1VnZsNmxmcHdm?=
 =?utf-8?B?M2lJa0RUVHh4aXBsNENPU1A2MGZhU3l2QStxcFROUkFXUWQybGR5dHNXYTJw?=
 =?utf-8?B?NFNFK016bVdYNksrSmdwQ0RBZkhCMnQ0NjVPMGFTQkJGUW9GR2JwY1BvS2No?=
 =?utf-8?B?SEpEZVpVWjdxL2h2djk2R2pNeHZlSmNLQ3k1cEp4SG1jdWFpQnI2ZlkyVlND?=
 =?utf-8?B?VTFXOWxpK0ZoMnZHa1h0QTN4T1AwbTBYM1VpYVd3S0prUUlhaTNtMkVWRDRN?=
 =?utf-8?B?WS91eXBzcHM2L3ZnWHpXcHZQZUp6Y0tubVhpa0MrcDNlZC9kQXh1QlVGNDhK?=
 =?utf-8?B?cU5wSnk2YW1vUHgwU1FJVlJ3SWhhK3gzUW9mcGJLbjRGUVpiWE5lc00ra2VO?=
 =?utf-8?B?aDlTVWtsWjdIeDlDcUszSXZEQlRURDgrbWdkMFNGWGtoRHovWTNzK2RZazVm?=
 =?utf-8?B?OXhiQzhlbzdEVFNsNDZrUm1oMHdIanYwQVFjM2RVR2ttMUNGWTVyd09UNFF0?=
 =?utf-8?B?VmEvRzJvTEpZWVBkME1PNFEzQVN4MEtDQ1FFU0F1cXlOSUlIOHBsNUtFaHZq?=
 =?utf-8?B?RXE2NlZSYnZBMEdRMW03THJXRGE4NVBHU1FuRE9SczBKNzlrVENyd2tQS0JY?=
 =?utf-8?B?SkdtYkNDdjNkbXZSbHowL0EwRzR5SzA3aVlZZ1kwdlhoUEowclNYMnY3TmtN?=
 =?utf-8?B?bmovYk5nVmFaNXdQS3lIc0RRTXZ2aSs0TjFZTXZQR3kzMEVURmdQRit5WDNE?=
 =?utf-8?B?dTVlajR2WERZaU1seGZPS0RqRkp0SDJTQmJOSlc1TE0yZW9ScG1MdDZadXlG?=
 =?utf-8?B?b2F6eC9peDQySG04VTN0T1AzVGdiTTBiTUxTVHBISlJCZ3E1SkI3dkJOMUlS?=
 =?utf-8?B?NnNEOEZrejR0cXBGbnIxM2pNTno5N1daOHlYaGZSTXJoUkZLYkx3STRRVEpQ?=
 =?utf-8?B?ZWpDeEp0d0Z3bHk1Nm5rSTRHRDMwbVVhQTN5NXpuQnh1MEU2eEoyYUlzYjNn?=
 =?utf-8?B?RERTcEYwSm1mTHBWd2lUVC82b0drTmIxU1I2WWpWYVlsWWo0YWFOWG40R051?=
 =?utf-8?B?TTdNNTFpVFI1bG9yTjYxZXc5Uy9vN0NpaFZVaXhFYVhHeEx2cVJPM29rRE11?=
 =?utf-8?B?bzBQMTA5R1AyMGllVmYzVE8zUzlVQm01SnFtMzM3ZEVKUzdmRXR2MXNWeXdp?=
 =?utf-8?B?Y3hnWmNEYll3QXViQ3RsNjMzQTNEaXkxNVRqRmtTL0thWWdReW01d2hNQm1Y?=
 =?utf-8?B?Tmp3OVFnL0c1ZnJ5WklPeVhNd1poOEtBVlJnamdWNFUwYlRxL3hNTVNaRUVY?=
 =?utf-8?Q?hNhpd9DEGdlPWMJRbHRe6wilq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00301385-ac55-491c-e23f-08db5b614c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 07:42:45.7559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eAZdEPIJFWqLsJAK65+8kzGTg+Vi1kxSPpKUZZxTtIP7a8S0c2xGwHCG/g8Mx+axbBj27ntsJEyClEeRtQorK/iPfVBoCf2WxmqQwC9T8Ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IFNhdHVyZGF5LCBNYXkgMTMsIDIwMjMgOToyOCBQTQ0KPlRv
OiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgamdnQG52aWRpYS5jb207IFRpYW4sIEtldmlu
DQo+PGtldmluLnRpYW5AaW50ZWwuY29tPg0KPkNjOiBqb3JvQDhieXRlcy5vcmc7IHJvYmluLm11
cnBoeUBhcm0uY29tOyBjb2h1Y2tAcmVkaGF0LmNvbTsNCj5lcmljLmF1Z2VyQHJlZGhhdC5jb207
IG5pY29saW5jQG52aWRpYS5jb207IGt2bUB2Z2VyLmtlcm5lbC5vcmc7DQo+bWpyb3NhdG9AbGlu
dXguaWJtLmNvbTsgY2hhby5wLnBlbmdAbGludXguaW50ZWwuY29tOyBMaXUsIFlpIEwNCj48eWku
bC5saXVAaW50ZWwuY29tPjsgeWkueS5zdW5AbGludXguaW50ZWwuY29tOyBwZXRlcnhAcmVkaGF0
LmNvbTsNCj5qYXNvd2FuZ0ByZWRoYXQuY29tOyBzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1
YXdlaS5jb207DQo+bHVsdUByZWRoYXQuY29tOyBzdXJhdmVlLnN1dGhpa3VscGFuaXRAYW1kLmNv
bTsgaW50ZWwtZ3Z0LQ0KPmRldkBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LQ0KPnMzOTBAdmdlci5rZXJuZWwub3JnOyBIYW8sIFh1
ZG9uZyA8eHVkb25nLmhhb0BpbnRlbC5jb20+OyBaaGFvLCBZYW4gWQ0KPjx5YW4ueS56aGFvQGlu
dGVsLmNvbT47IFh1LCBUZXJyZW5jZSA8dGVycmVuY2UueHVAaW50ZWwuY29tPjsgSmlhbmcsDQo+
WWFudGluZyA8eWFudGluZy5qaWFuZ0BpbnRlbC5jb20+OyBEdWFuLCBaaGVuemhvbmcNCj48emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPjsgY2xlZ29hdGVAcmVkaGF0LmNvbQ0KPlN1YmplY3Q6IFtQ
QVRDSCB2MTEgMDAvMjNdIEFkZCB2ZmlvX2RldmljZSBjZGV2IGZvciBpb21tdWZkIHN1cHBvcnQN
Cj4NCj5FeGlzdGluZyBWRklPIHByb3ZpZGVzIGdyb3VwLWNlbnRyaWMgdXNlciBBUElzIGZvciB1
c2Vyc3BhY2UuIFVzZXJzcGFjZSBvcGVucw0KPnRoZSAvZGV2L3ZmaW8vJGdyb3VwX2lkIGZpcnN0
IGJlZm9yZSBnZXR0aW5nIGRldmljZSBmZCBhbmQgaGVuY2UgZ2V0dGluZyBhY2Nlc3MNCj50byBk
ZXZpY2UuIFRoaXMgaXMgbm90IHRoZSBkZXNpcmVkIG1vZGVsIGZvciBpb21tdWZkLiBQZXIgdGhl
IGNvbmNsdXNpb24gb2YNCj5jb21tdW5pdHkgZGlzY3Vzc2lvblsxXSwgaW9tbXVmZCBwcm92aWRl
cyBkZXZpY2UtY2VudHJpYyBrQVBJcyBhbmQgcmVxdWlyZXMNCj5pdHMgY29uc3VtZXIgKGxpa2Ug
VkZJTykgdG8gYmUgZGV2aWNlLWNlbnRyaWMgdXNlciBBUElzLiBTdWNoIHVzZXIgQVBJcyBhcmUg
dXNlZA0KPnRvIGFzc29jaWF0ZSBkZXZpY2Ugd2l0aCBpb21tdWZkIGFuZCBhbHNvIHRoZSBJL08g
YWRkcmVzcyBzcGFjZXMgbWFuYWdlZA0KPmJ5IHRoZSBpb21tdWZkLg0KPg0KPlRoaXMgc2VyaWVz
IGZpcnN0IGludHJvZHVjZXMgYSBwZXIgZGV2aWNlIGZpbGUgc3RydWN0dXJlIHRvIGJlIHByZXBh
cmVkIGZvcg0KPmZ1cnRoZXIgZW5oYW5jZW1lbnQgYW5kIHJlZmFjdG9ycyB0aGUga3ZtLXZmaW8g
Y29kZSB0byBiZSBwcmVwYXJlZCBmb3INCj5hY2NlcHRpbmcgZGV2aWNlIGZpbGUgZnJvbSB1c2Vy
c3BhY2UuIEFmdGVyIHRoaXMsIGFkZHMgYSBtZWNoYW5pc20gZm9yDQo+YmxvY2tpbmcgZGV2aWNl
IGFjY2VzcyBiZWZvcmUgaW9tbXVmZCBiaW5kLiBUaGVuIHJlZmFjdG9ycyB0aGUgdmZpbyB0byBi
ZQ0KPmFibGUgdG8gaGFuZGxlIGNkZXYgcGF0aCAoZS5nLiBpb21tdWZkIGJpbmRpbmcsIG5vLWlv
bW11ZmQsIFtkZV1hdHRhY2ggaW9hcykuDQo+VGhpcyByZWZhY3RvciBpbmNsdWRlcyBtYWtpbmcg
dGhlIGRldmljZV9vcGVuIGV4Y2x1c2l2ZSBiZXR3ZWVuIHRoZSBncm91cA0KPmFuZCB0aGUgY2Rl
diBwYXRoLCBvbmx5IGFsbG93IHNpbmdsZSBkZXZpY2Ugb3BlbiBpbiBjZGV2IHBhdGg7IHZmaW8t
aW9tbXVmZA0KPmNvZGUgaXMgYWxzbyByZWZhY3RvcmVkIHRvIHN1cHBvcnQgY2Rldi4gZS5nLiBz
cGxpdCB0aGUgdmZpb19pb21tdWZkX2JpbmQoKQ0KPmludG8gdHdvIHN0ZXBzLiBFdmVudHVhbGx5
LCBhZGRzIHRoZSBjZGV2IHN1cHBvcnQgZm9yIHZmaW8gZGV2aWNlIGFuZCB0aGUgbmV3DQo+aW9j
dGxzLCB0aGVuIG1ha2VzIGdyb3VwIGluZnJhc3RydWN0dXJlIG9wdGlvbmFsIGFzIGl0IGlzIG5v
dCBuZWVkZWQgd2hlbiB2ZmlvDQo+ZGV2aWNlIGNkZXYgaXMgY29tcGlsZWQuDQo+DQo+VGhpcyBz
ZXJpZXMgaXMgYmFzZWQgb24gc29tZSBwcmVwYXJhdGlvbiB3b3JrcyBkb25lIHRvIHZmaW8gZW11
bGF0ZWQNCj5kZXZpY2VzWzJdIGFuZCB2ZmlvIHBjaSBob3QgcmVzZXQgZW5oYW5jZW1lbnRzWzNd
Lg0KPg0KPlRoaXMgc2VyaWVzIGlzIGEgcHJlcmVxdWlzaXRlIGZvciBpb21tdSBuZXN0aW5nIGZv
ciB2ZmlvIGRldmljZVs0XSBbNV0uDQo+DQo+VGhlIGNvbXBsZXRlIGNvZGUgY2FuIGJlIGZvdW5k
IGluIGJlbG93IGJyYW5jaCwgc2ltcGxlIHRlc3RzIGRvbmUgdG8gdGhlDQo+bGVnYWN5IGdyb3Vw
IHBhdGggYW5kIHRoZSBjZGV2IHBhdGguIERyYWZ0IFFFTVUgYnJhbmNoIGNhbiBiZSBmb3VuZCBh
dFs2XQ0KPkhvd2V2ZXIsIHRoZSBub2lvbW11IG1vZGUgdGVzdCBpcyBvbmx5IGRvbmUgd2l0aCBz
b21lIGhhY2tzIGluIGtlcm5lbCBhbmQNCj5xZW11IHRvIGNoZWNrIGlmIHFlbXUgY2FuIGJvb3Qg
d2l0aCBub2lvbW11IGRldmljZXMuDQo+DQo+aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9p
b21tdWZkL3RyZWUvdmZpb19kZXZpY2VfY2Rldl92MTENCj4oY29uZmlnIENPTkZJR19JT01NVUZE
PXkgQ09ORklHX1ZGSU9fREVWSUNFX0NERVY9eSkNCj4NCj5iYXNlLWNvbW1pdDogYjhiOTY3ZDVl
YzY5MWJkZGI4ODNhYjJhYmJmYjhkNjMyYzk3MDUyZQ0KPg0KPlsxXQ0KPmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2t2bS9CTjlQUjExTUI1NDMzQjFFNEFFNUIwNDgwMzY5Rjk3MTc4QzE4OQ0KPkBC
TjlQUjExTUI1NDMzLm5hbXByZDExLnByb2Qub3V0bG9vay5jb20vDQo+WzJdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2t2bS8yMDIzMDMyNzA5MzM1MS40NDUwNS0xLXlpLmwubGl1QGludGVsLmNv
bS8gLQ0KPm1lcmdlZCBbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtLzIwMjMwNTEzMTMy
MTM2LjE1MDIxLTEtDQo+eWkubC5saXVAaW50ZWwuY29tLw0KPls0XSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1pb21tdS8yMDIzMDUxMTE0Mzg0NC4yMjY5My0xLQ0KPnlpLmwubGl1QGlu
dGVsLmNvbS8NCj5bNV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMzA1
MTExNDUxMTAuMjc3MDctMS0NCj55aS5sLmxpdUBpbnRlbC5jb20vI3QNCj5bNl0NCj5odHRwczov
L2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvdHJlZS9pb21tdWZkX3JmY3Y0Lm1pZy5yZXNldC52
NF92YXIzDQo+DQo+Q2hhbmdlIGxvZzoNCj4NCj52MTE6DQo+IC0gQWRkIGJhY2sgdGhlIG5vaW9t
bXUgZGV0ZXJtaW5hdGlvbiBhdCB2ZmlvIGRldmljZSByZWdpc3RyYXRpb24gcGF0Y2ggYW5kDQo+
ICAgcHV0IGl0IHByaW9yIHRvIGNvbXBpbGluZyB2ZmlvX2dyb3VwIGNvZGUgb3B0aW9uYWxseSBh
cyBjb21waWxpbmcgdmZpb19ncm91cA0KPiAgIG9wdGlvbmFseSBpcyB0aGUgbWFqb3IgcmVhc29u
IGZvciBpdC4NCj4gLSBGaXggYSB0eXBvIHJlbGF0ZWQgdG8gU1BBUFIgKEPDqWRyaWMgTGUgR29h
dGVyKQ0KPiAtIEFkZCB0LWIgZnJvbSBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpLCB0ZXN0ZWQg
b24gSGlTaWxpY29uIEQwNihBUk02NCkNCj5wbGF0Zm9ybQ0KPiAgIHdpdGggYSBOSUMgcGFzcy10
aHJvdWdoDQo+DQo+djEwOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAyMzA0MjYxNTAz
MjEuNDU0NDY1LTEtDQo+eWkubC5saXVAaW50ZWwuY29tLw0KPiAtIERyb3AgcGF0Y2ggMDMgb2Yg
djkgYXMgdmZpb19maWxlX2lzX2dyb3VwKCkgaXMgc3RpbGwgbmVlZGVkIGJ5IHBjaSBob3QgcmVz
ZXQNCj5wYXRoDQo+IC0gRHJvcCAxMSBvZiB2OSBwZXIgdGhlIGNoYW5nZSBvZiBub2lvbW11IHN1
cHBvcnQNCj4gLSBNb3ZlIHBhdGNoIDE4IG9mIHY5IHRvIGhvdC1yZXNldCBzZXJpZXMgWzNdDQo+
IC0gdmZpb19maWxlX2hhc19kZXZpY2VfYWNjZXNzKCkgaXMgZHJvcHBlZCBhcyBubyB1c2FnZSBu
b3cgKGhvdC1yZXNldCBkb2VzDQo+bm90IGFjY2VwdA0KPiAgIGRldmljZSBmZCwgaGVuY2Ugbm8g
bmVlZCBmb3IgdGhpcyBoZWxwZXIpDQo+IC0gTWlub3IgY2hhbmdlIHRvIHBhdGNoIDAyLCBtYWlu
bHkgbWFrZSBpdCBiYWNrIHRvIHBhdGNoIHYyIG9mIHY2IHdoaWNoIGlzDQo+YmVmb3JlDQo+ICAg
c3BsaXR0aW5nIGhvdC1yZXNldCBzZXJpZXMNCj4gLSBNaW5vciBjaGFuZ2UgaW4gMTAgYW5kIDEx
IGR1ZSB0byByZWJhc2UNCj4gLSBGdW5jdGlvbmFsIGNoYW5nZXMgaW4gcGF0Y2ggMTksIDIwIGFu
ZCAyMSBwZXIgdGhlIGxhdGVzdCBub2lvbW11IHN1cHBvcnQNCj4gICBwb2xpY3kuIG5vaW9tbXUg
ZGV2aWNlIGNhbiBiZSBib3VuZCB0byB2YWxpZCBpb21tdWZkIG5vdywgdGhpcyBpcyBkaWZmZXJl
bnQNCj4gICBmcm9tIHRoZSBwcmlvciBwb2xpY3kgaW4gd2hpY2ggbm9pb21tdSBkZXZpY2UgaXMg
bm90IGFsbG93ZWQgdG8gYmUgYm91bmQgdG8NCj4gICB2YWxpZCBpb21tdWZkLiBTbyBtYXkgcGF5
IG1vcmUgYXR0ZW50aW9uIG9uIHRoZSB0aHJlZSBwYXRjaGVzLCBwcmV2aW91cyByLQ0KPmINCj4g
ICBhbmQgdC1iIGFyZSBkcm9wcGVkIGZvciB0aGVzZSB0aHJlZSBwYXRjaGVzLg0KPg0KPnY5OiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAyMzA0MDExNTE4MzMuMTI0NzQ5LTEteWkubC5s
aXVAaW50ZWwuY29tLw0KPiAtIFVzZSBzbXBfbG9hZF9hY3F1aXJlKCkgaW4gdmZpb19maWxlX2hh
c19kZXZpY2VfYWNjZXNzKCkgZm9yIGRmLQ0KPj5hY2Nlc3NfZ3JhbnRlZCAoQWxleCkNCj4gLSBG
aXggbG9jayBpbml0IGluIHBhdGNoIDE2IG9mIHY4IChKb24gUGFuLURvaCkNCj4gLSBTcGxpdCBw
YXRjaCAyMCBvZiB2OCAoQWxleCkNCj4gLSBSZWZpbmUgbm9pb21tdSBsb2dpYyBpbiBCSU5EX0lP
TU1VRkQgKEFsZXgpDQo+IC0gUmVtb3ZlIGRldl9jb29raWUgaW4gQklORF9JT01NVUZEIGlvY3Rs
IChBbGV4LCBKYXNvbikNCj4gLSBSZW1vdmUgc3RhdGljX2Fzc2VydCBpbiBBVFRBQ0gvREVUQUNI
IGlvY3RsIGhhbmRsaW5nIChBbGV4KQ0KPiAtIFJlbW92ZSBkZXZpY2UtPm9wcy0+YmluZF9pb21t
dWZkIHByZXNlbmNlIGNoZWNrIGluDQo+QklORF9JT01NVUZEL0FUVEFDSC9ERVRBQ0ggaGFuZGxp
bmcgKEFsZXgpDQo+IC0gUmVtb3ZlIFZGSU8gZGVwZW5kZWNueSBmb3IgVkZJT19DT05UQUlORVIg
YXMgVkZJT19HUk9VUCBzaG91bGQNCj5pbXBseSBpdCAoQWxleCkNCj4gLSBJbXByb3ZlIHRoZSBk
b2N1bWVudGF0aW9uIHBlciBzdWdnZXN0aW9ucyBmcm9tIEFsZXggb24gcGF0Y2ggMjQgb2YgdjgN
Cj4oQWxleCkNCj4gLSBSZW1vdmUgV0FSTl9PTihkZi0+Z3JvdXApIGluIHZmaW9fZGV2aWNlX2dy
b3VwX3VzZXNfY29udGFpbmVyKCkgb2YNCj5wYXRjaCAxMQ0KPiAtIEFkZCByLWIgZnJvbSBLZXZp
biB0byBwYXRjaCAxOC8xOSBvZiB2OA0KPiAtIEFkZCByLWIgZnJvbSBKYXNvbiB0byBwYXRjaCAw
My8xMC8xMSBvZiB2OA0KPiAtIEFkZCB0LWIgZnJvbSBZYW50aW5nIEppYW5nIGFuZCBOaWNvbGlu
IENoZW4NCj4NCj52ODogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtLzIwMjMwMzI3MDk0MDQ3
LjQ3MjE1LTEteWkubC5saXVAaW50ZWwuY29tLw0KPiAtIEFkZCBwYXRjaCAxOCB0byBkZXRlcm1p
bmUgbm9pb21tdSBkZXZpY2UgYXQgdmZpb19kZXZpY2UgcmVnaXN0cmF0aW9uDQo+KEphc29uKQ0K
PiAtIEFkZCBwYXRjaCAxOSB0byBuYW1lIG5vaW9tbXUgZGV2aWNlIHdpdGggIm5vaW9tbXUtIiBw
cmVmaXggdG8gYmUgcGFyDQo+d2l0aA0KPiAgIGdyb3VwIHBhdGgNCj4gLSBBZGQgci1iIGZyb20g
S2V2aW4NCj4gLSBBZGQgdC1iIGZyb20gVGVycmVuY2UNCj4NCj52NzogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcva3ZtLzIwMjMwMzE2MTI1NTM0LjE3MjE2LTEteWkubC5saXVAaW50ZWwuY29tLw0K
PiAtIFNwbGl0IHRoZSB2ZmlvLXBjaSBob3QgcmVzZXQgY2hhbmdlcyB0byBiZSBzZXBhcmF0ZSBw
YXRjaCBzZXJpZXMgKEphc29uLCBLZXZpbikNCj4gLSBNb3JlIHBvbGlzaCBvbiBuby1pb21tdWZk
IHN1cHBvcnQgKHBhdGNoIDExIC0gMTMpIGluIGNkZXYgcGF0aCAoS2V2aW4pDQo+IC0gaW9tbXVm
ZF9hY2Nlc3NfZGV0YWNoKCkgaW4gcGF0Y2ggMTYgaXMgYWRkZWQgYnkgTmljIGZvciBlbXVsYXRl
ZCBkZXZpY2VzDQo+KEtldmluLCBKYXNvbikNCj4NCj52NjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcva3ZtLzIwMjMwMzA4MTMyOTAzLjQ2NTE1OS0xLQ0KPnlpLmwubGl1QGludGVsLmNvbS8jdA0K
PiAtIEFkZCByLWIgZnJvbSBKYXNvbiBvbiBwYXRjaCAwMSAtIDA4IGFuZCAxMyBpbiB2NQ0KPiAt
IEJhc2VkIG9uIHRoZSBwcmVyZXF1aXNpdGUgbWluaS1zZXJpZXMgd2hpY2ggbWFrZXMgdmZpbyBl
bXVsYXRlZCBkZXZpY2VzDQo+ICAgYmUgcHJlcGFyZWQgdG8gY2RldiAoSmFzb24pDQo+IC0gQWRk
IHRoZSBhcHByb2FjaCB0byBwYXNzIGEgc2V0IG9mIGRldmljZSBmZHMgdG8gZG8gaG90IHJlc2V0
IG93bmVyc2hpcA0KPiAgIGNoZWNrLCB3aGlsZSB0aGUgemVyby1sZW5ndGggYXJyYXkgYXBwcm9h
Y2ggaXMgYWxzbyBrZXB0LiAoSmFzb24sIEtldmluLCBBbGV4KQ0KPiAtIERyb3AgcGF0Y2ggMTAg
b2YgdjUsIGl0IGlzIHJld29ya2VkIGJ5IHBhdGNoIDEzIGFuZCAxNyBpbiB2NiAoSmFzb24pDQo+
IC0gU3RvcmUgdmZpb19ncm91cCBwb2ludGVyIGluIHZmaW9fZGV2aWNlX2ZpbGUgdG8gY2hlY2sg
aWYgdXNlciBpcyB1c2luZw0KPiAgIGxlZ2FjeSB2ZmlvIGNvbnRhaW5lciAoSmFzb24pDQo+IC0g
RHJvcCB0aGUgaXNfY2Rldl9kZXZpY2UgZmxhZyAoaW50cm9kdWNlZCBpbiBwYXRjaCAxNCBvZiB2
NSkgYXMgdGhlIGdyb3VwDQo+ICAgcG9pbnRlciBzdG9yZWQgaW4gdmZpb19kZXZpY2VfZmlsZSBj
YW4gY292ZXIgaXQuDQo+IC0gQWRkIGlvbW11X2dyb3VwIGNoZWNrIGluIHRoZSBjZGV2IG5vLWlv
bW11IHBhdGggcGF0Y2ggMjQgKEtldmluKQ0KPiAtIEFkZCB0LWIgZnJvbSBUZXJyZW5jZSwgTmlj
b2xpbiBhbmQgTWF0dGhldyAodGhhbmtzIGZvciB0aGUgaGVscCwgc29tZQ0KPnBhdGNoZXMNCj4g
ICBhcmUgbmV3IGluIHRoaXMgdmVyc2lvbiwgc28gSSBqdXN0IGFkZGVkIHQtYiB0byB0aGUgcGF0
Y2hlcyB0aGF0IGFyZSBhbHNvDQo+ICAgaW4gdjUgYW5kIG5vIGJpZyBjaGFuZ2UsIGZvciBvdGhl
cnMgd291bGQgYWRkIGluIHRoaXMgdmVyc2lvbikuDQo+DQo+djU6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2t2bS8yMDIzMDIyNzExMTEzNS42MTcyOC0xLXlpLmwubGl1QGludGVsLmNvbS8NCj4g
LSBBZGQgci1iIGZyb20gS2V2aW4gb24gcGF0Y2ggMDgsIDEzLCAxNCwgMTUgYW5kIDE3Lg0KPiAt
IFJlbmFtZSBwYXRjaCAwMiB0byBsaW1pdCB0aGUgY2hhbmdlIGZvciBLVk0gZmFjaW5nIGtBUElz
LiBUaGUgdmZpbyBwY2kNCj4gICBob3QgcmVzZXQgcGF0aCBvbmx5IGFjY2VwdHMgZ3JvdXAgZmls
ZSB1bnRpbCBwYXRjaCAwOS4gKEtldmluKQ0KPiAtIFVwZGF0ZSBjb21tZW50IGFyb3VuZCBzbXBf
bG9hZF9hY3F1aXJlKCZkZi0+YWNjZXNzX2dyYW50ZWQpIChZYW4pDQo+IC0gQWRvcHQgSmFzb24n
cyBzdWdnZXN0aW9uIG9uIHRoZSB2ZmlvIHBjaSBob3QgcmVzZXQgcGF0aCwgcGFzc2luZyB6ZXJv
LWxlbmd0aA0KPiAgIGZkIGFycmF5IHRvIGluZGljYXRlIHVzaW5nIGJvdW5kIGlvbW11ZmRfY3R4
IGFzIG93bmVyc2hpcCBjaGVjay4gKEphc29uLA0KPktldmluKQ0KPiAtIERpcmVjdCByZWFkIGRm
LT5hY2Nlc3NfZ3JhbnRlZCB2YWx1ZSBpbiB2ZmlvX2RldmljZV9jZGV2X2Nsb3NlKCkgKEtldmlu
LCBZYW4sDQo+SmFzb24pDQo+IC0gV3JhcCB0aGUgaW9tbXVmZCBnZXQvcHV0IGludG8gYSBoZWxw
ZXIgdG8gcmVmaW5lIHRoZSBlcnJvciBwYXRoIG9mDQo+ICAgdmZpb19kZXZpY2VfaW9jdGxfYmlu
ZF9pb21tdWZkKCkuIChZYW4pDQo+DQo+djQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8y
MDIzMDIyMTAzNDgxMi4xMzgwNTEtMS15aS5sLmxpdUBpbnRlbC5jb20vDQo+IC0gQWRkIHItYiBm
cm9tIEtldmluIG9uIHBhdGNoIDA5LzEwDQo+IC0gQWRkIGEgbGluZSBpbiBkZXZpY2VzL3ZmaW8u
cnN0IHRvIGVtcGhhc2l6ZSB1c2VyIHNob3VsZCBhZGQgZ3JvdXAvZGV2aWNlIHRvDQo+ICAgS1ZN
IHByaW9yIHRvIGludm9rZSBvcGVuX2RldmljZSBvcCB3aGljaCBtYXkgYmUgY2FsbGVkIGluIHRo
ZQ0KPlZGSU9fR1JPVVBfR0VUX0RFVklDRV9GRA0KPiAgIG9yIFZGSU9fREVWSUNFX0JJTkRfSU9N
TVVGRCBpb2N0bC4NCj4gLSBNb2RpZnkgVkZJT19HUk9VUC9WRklPX0RFVklDRV9DREVWIEtjb25m
aWcgZGVwZW5kZW5jeSAoQWxleCkNCj4gLSBTZWxlY3QgVkZJT19HUk9VUCBmb3IgU1BBUFIgKEph
c29uKQ0KPiAtIENoZWNrIGRldmljZSBmdWxseS1vcGVuZWQgaW4gUENJIGhvdHJlc2V0IHBhdGgg
Zm9yIGRldmljZSBmZCAoSmFzb24pDQo+IC0gU2V0IGRmLT5hY2Nlc3NfZ3JhbnRlZCBpbiB0aGUg
Y2FsbGVyIG9mIHZmaW9fZGV2aWNlX29wZW4oKSBzaW5jZQ0KPiAgIHRoZSBjYWxsZXIgbWF5IGZh
aWwgaW4gb3RoZXIgb3BlcmF0aW9ucywgYnV0IGRmLT5hY2Nlc3NfZ3JhbnRlZA0KPiAgIGRvZXMg
bm90IGFsbG93IGEgdHJ1ZSB0byBmYWxzZSBjaGFuZ2UuIFNvIGl0IHNob3VsZCBiZSBzZXQgb25s
eSB3aGVuDQo+ICAgdGhlIG9wZW4gcGF0aCBpcyByZWFsbHkgZG9uZSBzdWNjZXNzZnVsbHkuIChZ
YW4sIEtldmluKQ0KPiAtIEZpeCBtaXNzaW5nIGlvbW11ZmRfY3R4X3B1dCgpIGluIHRoZSBjZGV2
IHBhdGggKFlhbikNCj4gLSBGaXggYW4gaXNzdWUgZm91bmQgaW4gdGVzdGluZyBleGNsdXNpb24g
YmV0d2VlbiBncm91cCBhbmQgY2RldiBwYXRoLg0KPiAgIHZmaW9fZGV2aWNlX2NkZXZfY2xvc2Uo
KSBzaG91bGQgY2hlY2sgZGYtPmFjY2Vzc19ncmFudGVkIGJlZm9yZSBoZWFkaW5nDQo+ICAgdG8g
b3RoZXIgb3BlcmF0aW9ucy4NCj4gLSBVcGRhdGUgdmZpby5yc3QgZm9yIGlvbW11ZmQvY2Rldg0K
Pg0KPnYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAyMzAyMTMxNTEzNDguNTY0NTEt
MS15aS5sLmxpdUBpbnRlbC5jb20vDQo+IC0gQWRkIHItYiBmcm9tIEtldmluIG9uIHBhdGNoIDAz
LCAwNiwgMDcsIDA4Lg0KPiAtIFJlZmluZSB0aGUgZ3JvdXAgYW5kIGNkZXYgcGF0aCBleGNsdXNp
b24uIFJlbW92ZSB2ZmlvX2RldmljZTpzaW5nbGVfb3BlbjsNCj4gICBhZGQgdmZpb19ncm91cDo6
Y2Rldl9kZXZpY2Vfb3Blbl9jbnQgdG8gYWNoaWV2ZSBleGx1Y3Npb24gYmV0d2VlbiBncm91cA0K
PiAgIHBhdGggYW5kIGNkZXYgcGF0aCAoS2V2aW4sIEphc29uKQ0KPiAtIEZpeCBhIGJ1ZyBpbiB0
aGUgZXJyb3IgaGFuZGxpbmcgcGF0aCAoWWFuIFpoYW8pDQo+IC0gQWRkcmVzcyBtaXNjIHJlbWFy
a3MgZnJvbSBLZXZpbg0KPg0KPnYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMjAyMzAy
MDYwOTA1MzIuOTU1OTgtMS15aS5sLmxpdUBpbnRlbC5jb20vDQo+IC0gQWRkIHItYiBmcm9tIEtl
dmluIGFuZCBFcmljIG9uIHBhdGNoIDAxIDAyIDA0Lg0KPiAtICJTcGxpdCBrdm0vdmZpbzogUHJv
dmlkZSBzdHJ1Y3Qga3ZtX2RldmljZV9vcHM6OnJlbGVhc2UoKSBpbnN0ZWQNCj5vZiA6OmRlc3Ry
b3koKSINCj4gICBmcm9tIHRoaXMgc2VyaWVzIGFuZCBnb3QgYXBwbGllZC4gKEFsZXgsIEtldmlu
LCBKYXNvbiwgTWF0aGhldykNCj4gLSBBZGQga3ZtX3JlZl9sb2NrIHRvIHByb3RlY3QgdmZpb19k
ZXZpY2VfZmlsZS0+a3ZtIGluc3RlYWQgb2YgcmV1c2luZw0KPiAgIGRldl9zZXQtPmxvY2sgYXMg
ZGVhZC1sb2NrIGlzIG9ic2VydmVkIHdpdGggdmZpby1hcCB3aGljaCB3b3VsZCB0cnkgdG8NCj4g
ICBhY3F1aXJlIGt2bV9sb2NrLiBUaGlzIGlzIG9wcG9zaXRlIGxvY2sgb3JkZXIgd2l0aCBrdm1f
ZGV2aWNlX3JlbGVhc2UoKQ0KPiAgIHdoaWNoIGhvbGRzIGt2bV9sb2NrIGZpcnN0IGFuZCB0aGVu
IGhvbGQgZGV2X3NldC0+bG9jay4gKEtldmluKQ0KPiAtIFVzZSBhIHNlcGFyYXRlIGlvY3RsIGZv
ciBkZXRhY2hpbmcgSU9BUy4gKEFsZXgpDQo+IC0gUmVuYW1lIHZmaW9fZGV2aWNlX2ZpbGU6OnNp
bmdsZV9vcGVuIHRvIGJlIGlzX2NkZXZfZGV2aWNlIChLZXZpbiwgQWxleCkNCj4gLSBNb3ZlIHRo
ZSB2ZmlvIGRldmljZSBjZGV2IGNvZGUgaW50byBkZXZpY2VfY2Rldi5jIGFuZCBhZGQgYQ0KPlZG
SU9fREVWSUNFX0NERVYNCj4gICBrY29uZmlnIGZvciBpdC4gKEtldmluLCBKYXNvbikNCj4NCj52
MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtLzIwMjMwMTE3MTM0OTQyLjEwMTExMi0xLXlp
LmwubGl1QGludGVsLmNvbS8NCj4gLSBGaXggdGhlIGNpcmN1bGFyIHJlZmNvdW50IGJldHdlZW4g
a3ZtIHN0cnVjdCBhbmQgZGV2aWNlIGZpbGUgcmVmZXJlbmNlLg0KPihKYXNvbkcpDQo+IC0gQWRk
cmVzcyBjb21tZW50cyBmcm9tIEtldmluVA0KPiAtIFJlbWFpbmVkIHRoZSBpb2N0bCBmb3IgZGV0
YWNoLCBuZWVkcyB0byBBbGV4J3MgdGFzdGUNCj4NCj4oaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
a3ZtL0JOOVBSMTFNQjUyNzZCRTlGNEIwNjEzRUU4NTkzMTcwMjhDRkY5DQo+QEJOOVBSMTFNQjUy
NzYubmFtcHJkMTEucHJvZC5vdXRsb29rLmNvbS8pDQo+DQo+cmZjOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9rdm0vMjAyMjEyMTkwODQ3MTguOTM0Mi0xLXlpLmwubGl1QGludGVsLmNvbS8NCj4N
Cj5UaGFua3MsDQo+CVlpIExpdQ0KPg0KPk5pY29saW4gQ2hlbiAoMSk6DQo+ICBpb21tdWZkL2Rl
dmljZTogQWRkIGlvbW11ZmRfYWNjZXNzX2RldGFjaCgpIEFQSQ0KPg0KPllpIExpdSAoMjIpOg0K
PiAgdmZpbzogQWxsb2NhdGUgcGVyIGRldmljZSBmaWxlIHN0cnVjdHVyZQ0KPiAgdmZpbzogUmVm
aW5lIHZmaW8gZmlsZSBrQVBJcyBmb3IgS1ZNDQo+ICB2ZmlvOiBBY2NlcHQgdmZpbyBkZXZpY2Ug
ZmlsZSBpbiB0aGUgS1ZNIGZhY2luZyBrQVBJDQo+ICBrdm0vdmZpbzogUmVuYW1lIGt2bV92Zmlv
X2dyb3VwIHRvIHByZXBhcmUgZm9yIGFjY2VwdGluZyB2ZmlvIGRldmljZQ0KPiAgICBmZA0KPiAg
a3ZtL3ZmaW86IEFjY2VwdCB2ZmlvIGRldmljZSBmaWxlIGZyb20gdXNlcnNwYWNlDQo+ICB2Zmlv
OiBQYXNzIHN0cnVjdCB2ZmlvX2RldmljZV9maWxlICogdG8gdmZpb19kZXZpY2Vfb3Blbi9jbG9z
ZSgpDQo+ICB2ZmlvOiBCbG9jayBkZXZpY2UgYWNjZXNzIHZpYSBkZXZpY2UgZmQgdW50aWwgZGV2
aWNlIGlzIG9wZW5lZA0KPiAgdmZpbzogQWRkIGNkZXZfZGV2aWNlX29wZW5fY250IHRvIHZmaW9f
Z3JvdXANCj4gIHZmaW86IE1ha2UgdmZpb19kZXZpY2Vfb3BlbigpIHNpbmdsZSBvcGVuIGZvciBk
ZXZpY2UgY2RldiBwYXRoDQo+ICB2ZmlvLWlvbW11ZmQ6IE1vdmUgbm9pb21tdSBjb21wYXQgcHJv
YmUgb3V0IG9mIHZmaW9faW9tbXVmZF9iaW5kKCkNCj4gIHZmaW8taW9tbXVmZDogU3BsaXQgYmlu
ZC9hdHRhY2ggaW50byB0d28gc3RlcHMNCj4gIHZmaW86IFJlY29yZCBkZXZpZCBpbiB2ZmlvX2Rl
dmljZV9maWxlDQo+ICB2ZmlvLWlvbW11ZmQ6IEFkZCBkZXRhY2hfaW9hcyBzdXBwb3J0IGZvciBw
aHlzaWNhbCBWRklPIGRldmljZXMNCj4gIHZmaW8taW9tbXVmZDogQWRkIGRldGFjaF9pb2FzIHN1
cHBvcnQgZm9yIGVtdWxhdGVkIFZGSU8gZGV2aWNlcw0KPiAgdmZpbzogTmFtZSBub2lvbW11IHZm
aW9fZGV2aWNlIHdpdGggIm5vaW9tbXUtIiBwcmVmaXgNCj4gIHZmaW86IE1vdmUgdmZpb19kZXZp
Y2VfZ3JvdXBfdW5yZWdpc3RlcigpIHRvIGJlIHRoZSBmaXJzdCBvcGVyYXRpb24gaW4NCj4gICAg
dW5yZWdpc3Rlcg0KPiAgdmZpbzogQWRkIGNkZXYgZm9yIHZmaW9fZGV2aWNlDQo+ICB2ZmlvOiBB
ZGQgVkZJT19ERVZJQ0VfQklORF9JT01NVUZEDQo+ICB2ZmlvOiBBZGQgVkZJT19ERVZJQ0VfW0FU
fERFXVRBQ0hfSU9NTVVGRF9QVA0KPiAgdmZpbzogRGV0ZXJtaW5lIG5vaW9tbXUgZGV2aWNlIGlu
IF9fdmZpb19yZWdpc3Rlcl9kZXYoKQ0KPiAgdmZpbzogQ29tcGlsZSB2ZmlvX2dyb3VwIGluZnJh
c3RydWN0dXJlIG9wdGlvbmFsbHkNCj4gIGRvY3M6IHZmaW86IEFkZCB2ZmlvIGRldmljZSBjZGV2
IGRlc2NyaXB0aW9uDQo+DQo+IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92ZmlvLnJzdCAgICAg
ICAgICAgICB8IDE0MCArKysrKysrKystDQo+IERvY3VtZW50YXRpb24vdmlydC9rdm0vZGV2aWNl
cy92ZmlvLnJzdCAgICAgICB8ICA0NyArKy0tDQo+IGRyaXZlcnMvZ3B1L2RybS9pOTE1L2d2dC9r
dm1ndC5jICAgICAgICAgICAgICB8ICAgMSArDQo+IGRyaXZlcnMvaW9tbXUvaW9tbXVmZC9LY29u
ZmlnICAgICAgICAgICAgICAgICB8ICAgNCArLQ0KPiBkcml2ZXJzL2lvbW11L2lvbW11ZmQvZGV2
aWNlLmMgICAgICAgICAgICAgICAgfCAgNzYgKysrKystDQo+IGRyaXZlcnMvaW9tbXUvaW9tbXVm
ZC9pb21tdWZkX3ByaXZhdGUuaCAgICAgICB8ICAgMiArDQo+IGRyaXZlcnMvczM5MC9jaW8vdmZp
b19jY3dfb3BzLmMgICAgICAgICAgICAgICB8ICAgMSArDQo+IGRyaXZlcnMvczM5MC9jcnlwdG8v
dmZpb19hcF9vcHMuYyAgICAgICAgICAgICB8ICAgMSArDQo+IGRyaXZlcnMvdmZpby9LY29uZmln
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNSArKw0KPiBkcml2ZXJzL3ZmaW8vTWFrZWZp
bGUgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKy0NCj4gZHJpdmVycy92ZmlvL2Rldmlj
ZV9jZGV2LmMgICAgICAgICAgICAgICAgICAgIHwgMjU4ICsrKysrKysrKysrKysrKysrKw0KPiBk
cml2ZXJzL3ZmaW8vZnNsLW1jL3ZmaW9fZnNsX21jLmMgICAgICAgICAgICAgfCAgIDEgKw0KPiBk
cml2ZXJzL3ZmaW8vZ3JvdXAuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxNTAgKysrKysr
LS0tLQ0KPiBkcml2ZXJzL3ZmaW8vaW9tbXVmZC5jICAgICAgICAgICAgICAgICAgICAgICAgfCAx
MjUgKysrKysrLS0tDQo+IC4uLi92ZmlvL3BjaS9oaXNpbGljb24vaGlzaV9hY2NfdmZpb19wY2ku
YyAgICB8ICAgMiArDQo+IGRyaXZlcnMvdmZpby9wY2kvbWx4NS9tYWluLmMgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQo+IGRyaXZlcnMvdmZpby9wY2kvdmZpb19wY2kuYyAgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQo+IGRyaXZlcnMvdmZpby9wY2kvdmZpb19wY2lfY29yZS5jICAgICAgICAg
ICAgICB8ICAxNiArLQ0KPiBkcml2ZXJzL3ZmaW8vcGxhdGZvcm0vdmZpb19hbWJhLmMgICAgICAg
ICAgICAgfCAgIDEgKw0KPiBkcml2ZXJzL3ZmaW8vcGxhdGZvcm0vdmZpb19wbGF0Zm9ybS5jICAg
ICAgICAgfCAgIDEgKw0KPiBkcml2ZXJzL3ZmaW8vdmZpby5oICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAyMzggKysrKysrKysrKysrKystLQ0KPiBkcml2ZXJzL3ZmaW8vdmZpb19tYWluLmMg
ICAgICAgICAgICAgICAgICAgICAgfCAyMjUgKysrKysrKysrKysrKy0tDQo+IGluY2x1ZGUvbGlu
dXgvaW9tbXVmZC5oICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+IGluY2x1ZGUvbGlu
dXgvdmZpby5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0NSArKy0NCj4gaW5jbHVkZS91
YXBpL2xpbnV4L2t2bS5oICAgICAgICAgICAgICAgICAgICAgIHwgIDEzICstDQo+IGluY2x1ZGUv
dWFwaS9saW51eC92ZmlvLmggICAgICAgICAgICAgICAgICAgICB8ICA4MCArKysrKysNCj4gc2Ft
cGxlcy92ZmlvLW1kZXYvbWJvY2hzLmMgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gc2Ft
cGxlcy92ZmlvLW1kZXYvbWRweS5jICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gc2Ft
cGxlcy92ZmlvLW1kZXYvbXR0eS5jICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gdmly
dC9rdm0vdmZpby5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTM3ICsrKysrLS0t
LS0NCj4gMzAgZmlsZXMgY2hhbmdlZCwgMTM2NSBpbnNlcnRpb25zKCspLCAyMzMgZGVsZXRpb25z
KC0pICBjcmVhdGUgbW9kZSAxMDA2NDQNCj5kcml2ZXJzL3ZmaW8vZGV2aWNlX2NkZXYuYw0KPg0K
Pi0tDQo+Mi4zNC4xDQoNClRlc3RlZCBub2lvbW11IG1vZGUgaW4gdHdvIHdheXMsIGJvdGggdGVz
dHMgcGFzc2VkLg0KT25lIHdheSBpcyBhbiBpeGdiZSBjYXJkIGluIG5vaW9tbXUgbW9kZSBwYXNz
dGhyb3VnaGVkIHRvIGd1ZXN0IHdpdGhvdXQgZG9pbmcgRE1BKG5lZWQgY2hhbmdpbmcgcWVtdSB0
byBvcGVuIG5vaW9tbXUgZGV2aWNlKS4NClRoZSBvdGhlciB3YXkgaXMgc2FtZSBpeGdiZSBjYXJk
IHVzZWQgaW4gRFBESyB0byByZWNlaXZlIHBhY2thZ2VzIGZyb20gYW5vdGhlciBzZXJ2ZXIuDQoN
ClRlc3RlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg==
