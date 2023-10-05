Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE47BA8C1
	for <lists+linux-s390@lfdr.de>; Thu,  5 Oct 2023 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjJESKC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 5 Oct 2023 14:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjJESJ3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Oct 2023 14:09:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4226D60;
        Thu,  5 Oct 2023 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696529354; x=1728065354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JLX5uMVfpOTiXzvFF7/v/ijQSUNBOSvRRxpVcLhbYOw=;
  b=KI6cIiUwq4tOwmLlXjDtv31cWjM6E/2nf021kmWE0ckx7jSDke+06ohs
   3HWfnIvXSb4fGr6Cd/1TKhUUrNIYksedPSJoCosEy6lxoB5ZMPjqZVkEG
   CGeLQUYqZ5SI5hMQOkwaJoJK36hxK7ToGEiXraOP9YOcrOxPnmVulMcTJ
   bXS5qA/dQGJ3lo2h8TcY2/L6T5hPkmx2MdcaJoC4LwbmwKiNN26ssDXPQ
   42nZOqnrS/nHuSbIe2JuutHpnC19iwBQ7C7BHnUs3Ys5KrsfEUeweSgQs
   /m7aham8qwPn+juBv9baEEbMlUpkPE/ZRsJCRnZicRU82tCayMvGkIGPI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363854099"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363854099"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:09:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895545633"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895545633"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 11:07:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:09:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 11:09:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 11:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQswGoy5eFunCZQ5A6fjWegnGrFVgZNSsC0TlRU4X1RavkJTEIF9NU2G70ENRAbP2XYt9O35PbAhZcURrmOFt7Esg650DKWYZpO+uvS/sia4orer8kVL61hKNH9GLCKPw50DGbBD9hHdIv3BTS1uFVNPXA8xESYNSzb4bgilcqPmEIXCFADQpUud/HpPB70lsHZ1jcT3fP77//ady/Rha0HbbVmPxfcZ0QU4VgiFqcvvoYcsOHHwLpGMm5RsKS/Joni74HpHhgjWLJHXHN5wfHuqZsWf2ImiHASPs+raNUvo7A2bY4KMhkTtWIhvWtQuMCufSjIZdvQUP1+MduYt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLX5uMVfpOTiXzvFF7/v/ijQSUNBOSvRRxpVcLhbYOw=;
 b=fKsNd5Bfa2JR9Am0bnK13EZrA7+5S1cctRIL9ZlnF5kJEzYTkO/XBVlpvvXXWj8PFGJ1hdEq5x+L/3q5CYUQ/icJHTfjpldL5NkZsUidPUoH6ohQnqNN8RL2oKAqppUXKLVWFdLMPg+DQGHR0mNlihejXIKmGlXSMr9eHyCZ6tPevsfvnlZ6vLcGSR0he5HrSsWnsOSUoZeoH+E5iGqZuPJLEI6iUDyKZMlnQozZLdlyaHcrx20HMLyIoUMmlLQOrxyiUbOYawh6MiV0L6Ua7aRqFM4XtXHPih8kMTptceYF++3MoIejSJv8R42+gjhZqW7dvjj68v5Xn3ENd0X+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 5 Oct
 2023 18:09:07 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::56f1:507b:133e:57cf%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:09:07 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "bjorn@kernel.org" <bjorn@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "puranjay12@gmail.com" <puranjay12@gmail.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "will@kernel.org" <will@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "song@kernel.org" <song@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 03/13] mm/execmem, arch: convert simple overrides of
 module_alloc to execmem
Thread-Topic: [PATCH v3 03/13] mm/execmem, arch: convert simple overrides of
 module_alloc to execmem
Thread-Index: AQHZ6gIbIXJGUlk14kaIslF+Xg+n8bA438mAgAD+GoCAAOcMAIAA1RsA
Date:   Thu, 5 Oct 2023 18:09:07 +0000
Message-ID: <b26d0a201bf631831a956450ebbccc3c16521133.camel@intel.com>
References: <20230918072955.2507221-1-rppt@kernel.org>
         <20230918072955.2507221-4-rppt@kernel.org>
         <607927885bb8ca12d4cd5787f01207c256cc8798.camel@intel.com>
         <00277a3acb36d2309156264c7e8484071bc91614.camel@intel.com>
         <20231005052622.GD3303@kernel.org>
In-Reply-To: <20231005052622.GD3303@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB6994:EE_
x-ms-office365-filtering-correlation-id: ad243a6b-a840-4e1d-95e9-08dbc5ce2a94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rB69I/qGTkNwaFzxfh26/PsqBDAY73O+y0/+r5jy72oIlhmI+gCnguHix0VfRpaDPhJz9yccuIWNMMnZ7RubdlnI3ewaw127QpibtfQgTAp+Lu79Wi1mjVNDlzAc5j0EKT/SePXOSuB2sPWO4KaGF3uLOVIgbrbfc1EFT59rnWHqNrDBQ83KjwTS3KUQcZ8eBs3GFhuLvKaB8o7iyM3xSLAUzkWIi0UZRGqJILKPJ4LO2GVZjrjnlXjmPZRZv9Pakaw6pNRW+UvsUi8BQ1/thluVFu9Jiugxpl1IV9n6Ltlnvc5NiyXVpybRpgUSjUbnL7gp6d7nj5qdU7JuJ9OU9pf6qSMiarsjP5/ZafRvNJmzP2lB5vxutpY0nbDkj99IhVEDBZKR4hHBVpj0WedhzWk8zu5PZj9JS5BykTp+wbtNmmCSVqUuu2lprSVw9LXoaw2evQYGr/hamYyyYB8jWVQaVNvMgSO/DkLc7XzLEwFNZi9YKv0ffuQ6pIpJWnUOfETnhgRi6r7h3wTEWkuTJL7CUifYbrYhmwWlHMKC7ln2ZBb9cWCJJcdZMYYbfBtT0EXUnYORr2mYHGzUwCbwH6tQz30DBH/5D7eH+U4Pp8RWSGJjdKmbNA4ErWGoBrLZmbnzHsaUfLTiEw7n+Skm2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(71200400001)(6512007)(6506007)(6486002)(82960400001)(122000001)(86362001)(38100700002)(38070700005)(36756003)(26005)(2616005)(64756008)(91956017)(7406005)(66556008)(76116006)(66946007)(66476007)(66446008)(54906003)(6916009)(7416002)(41300700001)(2906002)(5660300002)(8936002)(8676002)(4326008)(83380400001)(316002)(478600001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXk2L0FDcFdoaVBoRG8rd2llVVdGcVEvbWw1R3BnRzVmeE43NVRjUFpkWXAv?=
 =?utf-8?B?WmJYdXVqYlNhZUtPWmhCQW5CanF6VGFLTXhXMm4vNy9OVURqS09mbDNSZVNm?=
 =?utf-8?B?YWpJOUJVTFRqZlBEVFVyRzFPSS9nMzl0K0ZFVk1vd1lpN0NCc1JISDNQdU54?=
 =?utf-8?B?UFd6VFYxT2dWOUtZdzlGQWlab0RXc1JwNFVxMloxekF2VmN6Vm5UVDc5NHdj?=
 =?utf-8?B?R1FsN1JhRGhmMjRoTWlMY0YrTitvdDdhNlFxc3h0cTFrb1ZhbWdwbnhTcVMv?=
 =?utf-8?B?cFg5V2FxbHJlTGQ0UklqbVRNQ0Z6aDVVSlVKaE1Wc1FmYWZCUXF3VERPUk91?=
 =?utf-8?B?THFaRXcrem1nbW5oaHhzMmxnVG1OL0FlVlk5M21lSnpsRlYwbDhUN3F1SlBr?=
 =?utf-8?B?V0lxNmdqWU5SYVg3eHNUVHZzdlhXdyszVEFaZjBwbHNqMUwveWIvb09RWVNZ?=
 =?utf-8?B?cmlkM1Z1dlJMRmJCZVJKR041MzdnUVFpMnVBYzQydC9ic2djMGkrYUZpZzFp?=
 =?utf-8?B?Q2Q4L3gwQkh0dFNIZmt0S0VJcWI0NXZlakhnU0NmT1RWalVueEJ5TlRZenNu?=
 =?utf-8?B?bFpPQTJ6bVNwTFAyOUNqajUwaVlyRHg1a29tZjRPZGFqRzZwZElGSmFNMVhB?=
 =?utf-8?B?K3VlUTdQN1grVlQwYXZpbGVCWit0WGMwOGdodG1NcU9aeGpqS3hHQnVEUE1D?=
 =?utf-8?B?ZnFQQ1Z2blVDWTliNDlUNlVNSGFheUpJbzJpeGlsQVF2V1lmVlpuWU5EWDVp?=
 =?utf-8?B?OUJibVlPWVRvUTFTSVNFLzl2Q3VMbEd1NEsxQndhSEFBejBrVlhzOVhkdjAr?=
 =?utf-8?B?TUJlODhHNHdWbmxUZGFIWkZmY24ybG9UZVVzMUVYQTVlZkpJQTZTT21ua0Nu?=
 =?utf-8?B?TkR5TGoxT0svemhKYUZTMHNiYkZGVmtKQmFQVE1FSE41Z2cwSVI0ZFM0ajRK?=
 =?utf-8?B?SGFUY2VKb0xEV1dPNDNDbUlmM3Z2WDc2Yk5KU1ZwNVhGSGtTbVdQTEthczRE?=
 =?utf-8?B?aHRjK2N2TG90ZE1TWWM5ang1clZ2am14bW5UMEpKckEvN3VxVWhCRGZJRUpH?=
 =?utf-8?B?cjdMcHVWeUZSVDdHT2lBWlZuYk56d3MreFQrQ2lRQWNMYUlqS2VIQmxhK2p1?=
 =?utf-8?B?RGFYOUt1ZmNUZ3pPb0pxVktVWHIxcmxMak16MWs1VkhqUkJpakJwVk1wOWVQ?=
 =?utf-8?B?aVdoTDl2YTM3WFRWTU92N2VMdXdtaUV6eEJvOC9qcWR0N0xlWWpZSTByeVZS?=
 =?utf-8?B?TmZnNUkvNjY5anVFcUU2WHlmZ2d2WUNsV04rMVE4YWVlZkFvTS96OUNYRjh5?=
 =?utf-8?B?dUQzd1ZETEo4ajNKR29MeEpTamdLcjZicnlYVG1oQ0g1WGkxR081aHR4bTBw?=
 =?utf-8?B?OFpnR25mTUJFY2xQelFWdHBWNy9qVVpPQzRxK0hNSmZYb0Z6TTB6ODgzVGpL?=
 =?utf-8?B?Z0J3UGFJcVRIdFQ4Tm5GNzFRL1EyZjU1czIzSElkS1YwRFhNVForUFNyZ3Yr?=
 =?utf-8?B?ZmlOTlEvS3NtZytNcUhieUVoZDNObndzT1VsUXU4U1ZtWklFdThPRGxvV1Mx?=
 =?utf-8?B?TzNib2I0WnoxQVNuZEpmZDBVdGJoQ29YSFNpOVA3alk4dk85aERYNEYxR1or?=
 =?utf-8?B?QTFxcTFtdGxlTnB5ZkQ2aXltWFVYMi8vMUtpa0FxTktESzhqb3lzTnZIY2cr?=
 =?utf-8?B?c3k3QVNpeDhnUkt5by9wc1kvZ2NhYVVjYXdpTFJ4Q2NTZHN5d2EyRkc1NHRq?=
 =?utf-8?B?d0xFMkFvRnVSWEd1WFJtMEFsRmxsclFOYkY5eUluQ1RBVHo0VFg1YTc1TjBZ?=
 =?utf-8?B?SFNsb2g2RDkrc005WktxWHhhU25ValM0czVNTzRYWmFEby9VSlVWUjRiSnNK?=
 =?utf-8?B?dzh1Q2t4amg4YjcrRy9pM2RmQW1aaGd3MFk1MVV0Rk5ua00ySlNHMXJGZFFY?=
 =?utf-8?B?eDJoM2w1ekhSd3lXZms4SjBOT3FraDRCdjJhaURhNnJydUM3M0U2dkdGZWpu?=
 =?utf-8?B?aFBNNGRFZittTDdxVXZidnM1aFRDdzdQS2Q1WFZ4VW1OcFVIVVJyR3NuSWR5?=
 =?utf-8?B?YVBGYk9oN0haMzdSc2h0WFk0M3A4TFVEVDAwODYxQTNHdnhkZzgxZjF2aHZw?=
 =?utf-8?B?dFNhVUR1dmU2aE5zRlBZZDhZOGFmMndYR3g4QkhzZFA5UVlmWlA5ek5yRDd3?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <982D946EFFC8D64D8B47A9BC2373DD2A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad243a6b-a840-4e1d-95e9-08dbc5ce2a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 18:09:07.0950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QICt27AF2WB2L6z+lJdwYK4yEy17GZF+kHThrsBKbPN3+C/BBK0DAzVHN3IjwqFYZM4yeF9n6yJZRrWPYd5xgLsoR7QhOgcCWKz+3e36VA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDA4OjI2ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBXZWQsIE9jdCAwNCwgMjAyMyBhdCAwMzozOToyNlBNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjMtMTAtMDMgYXQgMTc6MjkgLTA3MDAsIFJpY2sg
RWRnZWNvbWJlIHdyb3RlOg0KPiA+ID4gSXQgc2VlbXMgYSBiaXQgd2VpcmQgdG8gY29weSBhbGwg
b2YgdGhpcy4gSXMgaXQgdHJ5aW5nIHRvIGJlDQo+ID4gPiBmYXN0ZXINCj4gPiA+IG9yDQo+ID4g
PiBzb21ldGhpbmc/DQo+ID4gPiANCj4gPiA+IENvdWxkbid0IGl0IGp1c3QgY2hlY2sgci0+c3Rh
cnQgaW4gZXhlY21lbV90ZXh0L2RhdGFfYWxsb2MoKSBwYXRoDQo+ID4gPiBhbmQNCj4gPiA+IHN3
aXRjaCB0byBFWEVDTUVNX0RFRkFVTFQgaWYgbmVlZGVkIHRoZW4/IFRoZQ0KPiA+ID4gZXhlY21l
bV9yYW5nZV9pc19kYXRhKCkNCj4gPiA+IHBhcnQgdGhhdCBjb21lcyBsYXRlciBjb3VsZCBiZSBh
ZGRlZCB0byB0aGUgbG9naWMgdGhlcmUgdG9vLiBTbw0KPiA+ID4gdGhpcw0KPiA+ID4gc2VlbXMg
bGlrZSB1bm5lY2Vzc2FyeSBjb21wbGV4aXR5IHRvIG1lIG9yIEkgZG9uJ3Qgc2VlIHRoZQ0KPiA+
ID4gcmVhc29uLg0KPiA+IA0KPiA+IEkgZ3Vlc3MgdGhpcyBpcyBhIGJhZCBpZGVhIGJlY2F1c2Ug
aWYgeW91IGhhdmUgdGhlIGZ1bGwgc2l6ZSBhcnJheQ0KPiA+IHNpdHRpbmcgYXJvdW5kIGFueXdh
eSB5b3UgbWlnaHQgYXMgd2VsbCB1c2UgaXQgYW5kIHJlZHVjZSB0aGUNCj4gPiBleGVjX21lbV9h
bGxvYygpIGxvZ2ljLg0KPiANCj4gVGhhdCdzIHdhcyB0aGUgaWRlYSwgaW5kZWVkLiA6KQ0KPiAN
Cj4gPiBKdXN0IGxvb2tpbmcgYXQgaXQgZnJvbSB0aGUgeDg2IHNpZGUgKGFuZA0KPiA+IHNpbWls
YXIpIHRob3VnaCwgd2hlcmUgdGhlcmUgaXMgYWN0dWFsbHkgb25seSBvbmUgZXhlY21lbV9yYW5n
ZSBhbmQNCj4gPiBpdA0KPiA+IGJ1aWxkaW5nIHRoaXMgd2hvbGUgYXJyYXkgd2l0aCBpZGVudGlj
YWwgZGF0YSBhbmQgaXQgc2VlbXMgd2VpcmQuDQo+IA0KPiBSaWdodCwgbW9zdCBhcmNoaXRlY3R1
cmVzIGhhdmUgb25seSBvbmUgcmFuZ2UsIGJ1dCB0byBzdXBwb3J0IGFsbA0KPiB2YXJpYW50cw0K
PiB0aGF0IHdlIGhhdmUsIGV4ZWNtZW0gaGFzIHRvIG1haW50YWluIHRoZSB3aG9sZSBhcnJheS4N
Cg0KV2hhdCBhYm91dCBqdXN0IGhhdmluZyBhbiBpbmRleCBpbnRvIGEgc21hbGxlciBzZXQgb2Yg
cmFuZ2VzLiBUaGUNCm1vZHVsZSBhcmVhIGFuZCB0aGUgZXh0cmEgSklUIGFyZWEuIFNvIC0+cmFu
Z2VzIGNhbiBiZSBzaXplIDMNCihzdGF0aWNhbGx5IGFsbG9jYXRlZCBpbiB0aGUgYXJjaCBjb2Rl
KSBmb3IgdGhyZWUgYXJlYXMgYW5kIHRoZW4gdGhlDQppbmRleCBhcnJheSBjYW4gYmUgc2l6ZSBF
WEVDTUVNX1RZUEVfTUFYLiBUaGUgZGVmYXVsdCAwIHZhbHVlIG9mIHRoZQ0KaW5kZXhpbmcgYXJy
YXkgd2lsbCBwb2ludCB0byB0aGUgZGVmYXVsdCBhcmVhIGFuZCBhbnkgc3BlY2lhbCBhcmVhcyBj
YW4NCmJlIHNldCBpbiB0aGUgaW5kZXggcG9pbnQgdG8gdGhlIGRlc2lyZWQgcmFuZ2UuDQoNCkxv
b2tpbmcgYXQgaG93IGl0IHdvdWxkIGRvIGZvciB4ODYgYW5kIGFybTY0LCBpdCBsb29rcyBtYXli
ZSBhIGJpdA0KYmV0dGVyIHRvIG1lLiBBIGxpdHRsZSBiaXQgbGVzcyBjb2RlIGFuZCBtZW1vcnkg
dXNhZ2UsIGFuZCBhIGJpdCBlYXNpZXINCnRvIHRyYWNlIHRoZSBjb25maWd1cmF0aW9uIHRocm91
Z2ggdG8gdGhlIGZpbmFsIHN0YXRlIChJTU8pLiBXaGF0IGRvDQp5b3UgdGhpbms/IFZlcnkgcm91
Z2gsIG9uIHRvcCBvZiB0aGlzIHNlcmllcywgYmVsb3cuDQoNCkFzIEkgd2FzIHBsYXlpbmcgYXJv
dW5kIHdpdGggdGhpcywgSSB3YXMgYWxzbyB3b25kZXJpbmcgd2h5IGl0IG5lZWRzDQp0d28gY29w
aWVzIG9mIHN0cnVjdCBleGVjbWVtX3BhcmFtczogb25lIHJldHVybmVkIGZyb20gdGhlIGFyY2gg
Y29kZQ0KYW5kIG9uZSBpbiBleGVjIG1lbS4gQW5kIHdoeSB0aGUgdGVtcG9yYXJ5IGFyY2ggY29w
eSBpcyByb19hZnRlcl9pbml0LA0KYnV0IHRoZSBmaW5hbCBleGVjbWVtLmMgY29weSBpcyBub3Qg
cm9fYWZ0ZXJfaW5pdD8NCg0KIGFyY2gvYXJtNjQvbW0vaW5pdC5jICAgIHwgNjcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQogYXJjaC94ODYvbW0vaW5pdC5jICAgICAgfCAyNCArKysrKysrKysrKysrLS0tLS0tLS0t
LS0NCiBpbmNsdWRlL2xpbnV4L2V4ZWNtZW0uaCB8ICA1ICsrKy0tDQogbW0vZXhlY21lbS5jICAg
ICAgICAgICAgfCA2MSArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKyks
IDg3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9pbml0LmMgYi9h
cmNoL2FybTY0L21tL2luaXQuYw0KaW5kZXggOWI3NzE2YjRkODRjLi43ZGYxMTkxMDFmMjAgMTAw
NjQ0DQotLS0gYS9hcmNoL2FybTY0L21tL2luaXQuYw0KKysrIGIvYXJjaC9hcm02NC9tbS9pbml0
LmMNCkBAIC02MzMsNDkgKzYzMyw1OCBAQCBzdGF0aWMgaW50IF9faW5pdCBtb2R1bGVfaW5pdF9s
aW1pdHModm9pZCkNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyBzdHJ1Y3QgZXhlY21lbV9w
YXJhbXMgZXhlY21lbV9wYXJhbXMgX19yb19hZnRlcl9pbml0ID0gew0KLQkucmFuZ2VzID0gew0K
LQkJW0VYRUNNRU1fREVGQVVMVF0gPSB7DQotCQkJLmZsYWdzID0gRVhFQ01FTV9LQVNBTl9TSEFE
T1csDQotCQkJLmFsaWdubWVudCA9IE1PRFVMRV9BTElHTiwNCi0JCX0sDQotCQlbRVhFQ01FTV9L
UFJPQkVTXSA9IHsNCi0JCQkuc3RhcnQgPSBWTUFMTE9DX1NUQVJULA0KLQkJCS5lbmQgPSBWTUFM
TE9DX0VORCwNCi0JCQkuYWxpZ25tZW50ID0gMSwNCi0JCX0sDQotCQlbRVhFQ01FTV9CUEZdID0g
ew0KLQkJCS5zdGFydCA9IFZNQUxMT0NfU1RBUlQsDQotCQkJLmVuZCA9IFZNQUxMT0NfRU5ELA0K
LQkJCS5hbGlnbm1lbnQgPSAxLA0KLQkJfSwNCitzdGF0aWMgc3RydWN0IGV4ZWNtZW1fcmFuZ2Vb
Ml0gcmFuZ2VzIF9fcm9fYWZ0ZXJfaW5pdCA9IHsNCisJLyogTW9kdWxlIGFyZWEgKi8NCisJWzBd
ID0gew0KKwkJLmZsYWdzID0gRVhFQ01FTV9LQVNBTl9TSEFET1csDQorCQkuYWxpZ25tZW50ID0g
TU9EVUxFX0FMSUdOLA0KKwl9LA0KKwkvKiBLcHJvYmVzIGFyZWEgKi8NCisJWzFdID0gew0KKwkJ
LnN0YXJ0ID0gVk1BTExPQ19TVEFSVCwNCisJCS5lbmQgPSBWTUFMTE9DX0VORCwNCisJCS5hbGln
bm1lbnQgPSAxLA0KKwl9LA0KKwkvKiBCUEYgYXJlYSAqLw0KKwlbMl0gPSB7DQorCQkuc3RhcnQg
PSBWTUFMTE9DX1NUQVJULA0KKwkJLmVuZCA9IFZNQUxMT0NfRU5ELA0KKwkJLmFsaWdubWVudCA9
IDEsDQogCX0sDQogfTsNCiANCi1zdHJ1Y3QgZXhlY21lbV9wYXJhbXMgX19pbml0ICpleGVjbWVt
X2FyY2hfcGFyYW1zKHZvaWQpDQordm9pZCBfX2luaXQgZXhlY21lbV9hcmNoX3BhcmFtcyhzdHJ1
Y3QgZXhlY21lbV9wYXJhbXMgKnApDQogew0KLQlzdHJ1Y3QgZXhlY21lbV9yYW5nZSAqciA9DQom
ZXhlY21lbV9wYXJhbXMucmFuZ2VzW0VYRUNNRU1fREVGQVVMVF07DQorCXN0cnVjdCBleGVjbWVt
X3JhbmdlICpkZWZhdWx0Ow0KKwlzdHJ1Y3QgZXhlY21lbV9yYW5nZSAqaml0Ow0KKw0KKwlwLT5y
YW5nZXMgPSAmcmFuZ2VzOw0KIA0KIAltb2R1bGVfaW5pdF9saW1pdHMoKTsNCiANCi0Jci0+cGdw
cm90ID0gUEFHRV9LRVJORUw7DQotDQorCS8qIERlZmF1bHQgYXJlYSAqLw0KKwlkZWZhdWx0ID0g
JnJhbmdlc1swXTsNCisJZGVmYXVsdC0+cGdwcm90ID0gUEFHRV9LRVJORUw7DQogCWlmIChtb2R1
bGVfZGlyZWN0X2Jhc2UpIHsNCi0JCXItPnN0YXJ0ID0gbW9kdWxlX2RpcmVjdF9iYXNlOw0KLQkJ
ci0+ZW5kID0gbW9kdWxlX2RpcmVjdF9iYXNlICsgU1pfMTI4TTsNCisJCWRlZmF1bHQtPnN0YXJ0
ID0gbW9kdWxlX2RpcmVjdF9iYXNlOw0KKwkJZGVmYXVsdC0+ZW5kID0gbW9kdWxlX2RpcmVjdF9i
YXNlICsgU1pfMTI4TTsNCiANCiAJCWlmIChtb2R1bGVfcGx0X2Jhc2UpIHsNCi0JCQlyLT5mYWxs
YmFja19zdGFydCA9IG1vZHVsZV9wbHRfYmFzZTsNCi0JCQlyLT5mYWxsYmFja19lbmQgPSBtb2R1
bGVfcGx0X2Jhc2UgKyBTWl8yRzsNCisJCQlkZWZhdWx0LT5mYWxsYmFja19zdGFydCA9IG1vZHVs
ZV9wbHRfYmFzZTsNCisJCQlkZWZhdWx0LT5mYWxsYmFja19lbmQgPSBtb2R1bGVfcGx0X2Jhc2Ug
Kw0KU1pfMkc7DQogCQl9DQogCX0gZWxzZSBpZiAobW9kdWxlX3BsdF9iYXNlKSB7DQotCQlyLT5z
dGFydCA9IG1vZHVsZV9wbHRfYmFzZTsNCi0JCXItPmVuZCA9IG1vZHVsZV9wbHRfYmFzZSArIFNa
XzJHOw0KKwkJZGVmYXVsdC0+c3RhcnQgPSBtb2R1bGVfcGx0X2Jhc2U7DQorCQlkZWZhdWx0LT5l
bmQgPSBtb2R1bGVfcGx0X2Jhc2UgKyBTWl8yRzsNCiAJfQ0KIA0KLQlleGVjbWVtX3BhcmFtcy5y
YW5nZXNbRVhFQ01FTV9LUFJPQkVTXS5wZ3Byb3QgPQ0KUEFHRV9LRVJORUxfUk9YOw0KLQlleGVj
bWVtX3BhcmFtcy5yYW5nZXNbRVhFQ01FTV9CUEZdLnBncHJvdCA9IFBBR0VfS0VSTkVMOw0KKwkv
KiBKaXQgYXJlYSAqLw0KKwlyYW5nZXNbMV0ucGdwcm90ID0gUEFHRV9LRVJORUxfUk9YOw0KKwlw
LT5kZWZhdWx0c1tFWEVDTUVNX0tQUk9CRVNdID0gMTsNCisJDQogDQotCXJldHVybiAmZXhlY21l
bV9wYXJhbXM7DQorCS8qIEJQRiBBcmVhICovDQorCXJhbmdlc1syXS5wZ3Byb3QgPSBQQUdFX0tF
Uk5FTDsNCisJcC0+ZGVmYXVsdHNbRVhFQ01FTV9CUEZdID0gMjsNCiB9DQogI2VuZGlmDQpkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvbW0vaW5pdC5jIGIvYXJjaC94ODYvbW0vaW5pdC5jDQppbmRleCAw
MjJhZjdhYjUwZjkuLjczOTc0NzJmZmMzOSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L21tL2luaXQu
Yw0KKysrIGIvYXJjaC94ODYvbW0vaW5pdC5jDQpAQCAtMTEwMiwxNiArMTEwMiwxNSBAQCB1bnNp
Z25lZCBsb25nIGFyY2hfbWF4X3N3YXBmaWxlX3NpemUodm9pZCkNCiAjZW5kaWYNCiANCiAjaWZk
ZWYgQ09ORklHX0VYRUNNRU0NCi1zdGF0aWMgc3RydWN0IGV4ZWNtZW1fcGFyYW1zIGV4ZWNtZW1f
cGFyYW1zIF9fcm9fYWZ0ZXJfaW5pdCA9IHsNCi0JLnJhbmdlcyA9IHsNCi0JCVtFWEVDTUVNX0RF
RkFVTFRdID0gew0KLQkJCS5mbGFncyA9IEVYRUNNRU1fS0FTQU5fU0hBRE9XLA0KLQkJCS5hbGln
bm1lbnQgPSBNT0RVTEVfQUxJR04sDQotCQl9LA0KK3N0YXRpYyBzdHJ1Y3QgZXhlY21lbV9yYW5n
ZSByYW5nZXNbMV0gX19yb19hZnRlcl9pbml0ID0gew0KKwkvKiBNb2R1bGUgYXJlYSAqLw0KKwlb
MF0gPSB7DQorCQkuZmxhZ3MgPSBFWEVDTUVNX0tBU0FOX1NIQURPVywNCisJCS5hbGlnbm1lbnQg
PSBNT0RVTEVfQUxJR04sDQogCX0sDQogfTsNCiANCi1zdHJ1Y3QgZXhlY21lbV9wYXJhbXMgX19p
bml0ICpleGVjbWVtX2FyY2hfcGFyYW1zKHZvaWQpDQordm9pZCBfX2luaXQgZXhlY21lbV9hcmNo
X3BhcmFtcyhzdHJ1Y3QgZXhlY21lbV9wYXJhbXMgKnApDQogew0KIAl1bnNpZ25lZCBsb25nIG1v
ZHVsZV9sb2FkX29mZnNldCA9IDA7DQogCXVuc2lnbmVkIGxvbmcgc3RhcnQ7DQpAQCAtMTEyMSwx
MCArMTEyMCwxMyBAQCBzdHJ1Y3QgZXhlY21lbV9wYXJhbXMgX19pbml0DQoqZXhlY21lbV9hcmNo
X3BhcmFtcyh2b2lkKQ0KIAkJCWdldF9yYW5kb21fdTMyX2luY2x1c2l2ZSgxLCAxMDI0KSAqIFBB
R0VfU0laRTsNCiANCiAJc3RhcnQgPSBNT0RVTEVTX1ZBRERSICsgbW9kdWxlX2xvYWRfb2Zmc2V0
Ow0KLQlleGVjbWVtX3BhcmFtcy5yYW5nZXNbRVhFQ01FTV9ERUZBVUxUXS5zdGFydCA9IHN0YXJ0
Ow0KLQlleGVjbWVtX3BhcmFtcy5yYW5nZXNbRVhFQ01FTV9ERUZBVUxUXS5lbmQgPSBNT0RVTEVT
X0VORDsNCi0JZXhlY21lbV9wYXJhbXMucmFuZ2VzW0VYRUNNRU1fREVGQVVMVF0ucGdwcm90ID0g
UEFHRV9LRVJORUw7DQorCXAtPnJhbmdlcyA9IHJhbmdlczsNCiANCi0JcmV0dXJuICZleGVjbWVt
X3BhcmFtczsNCisJLyogTW9kdWxlIGFyZWEgKi8NCisJcC0+cmFuZ2VzWzBdLnN0YXJ0ID0gc3Rh
cnQ7DQorCXAtPnJhbmdlc1swXS5lbmQgPSBNT0RVTEVTX0VORDsNCisJcC0+cmFuZ2VzWzBdLnBn
cHJvdCA9IFBBR0VfS0VSTkVMOw0KKwlwLT5yYW5nZXNbMF0uZmxhZ3MgPSBFWEVDTUVNX0tBU0FO
X1NIQURPVzsNCisJcC0+cmFuZ2VzWzBdLmFsaWdubWVudCA9IE1PRFVMRV9BTElHTjsNCiB9DQog
I2VuZGlmIC8qIENPTkZJR19FWEVDTUVNICovDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9l
eGVjbWVtLmggYi9pbmNsdWRlL2xpbnV4L2V4ZWNtZW0uaA0KaW5kZXggMDlkNDVhYzc4NmU5Li43
MDI0MzU0NDNkODcgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2V4ZWNtZW0uaA0KKysrIGIv
aW5jbHVkZS9saW51eC9leGVjbWVtLmgNCkBAIC03Nyw3ICs3Nyw4IEBAIHN0cnVjdCBleGVjbWVt
X3JhbmdlIHsNCiAgKiBlYWNoIHR5cGUgb2YgZXhlY3V0YWJsZSBtZW1vcnkgYWxsb2NhdGlvbnMN
CiAgKi8NCiBzdHJ1Y3QgZXhlY21lbV9wYXJhbXMgew0KLQlzdHJ1Y3QgZXhlY21lbV9yYW5nZQly
YW5nZXNbRVhFQ01FTV9UWVBFX01BWF07DQorCWludCBhcmVhc1tFWEVDTUVNX1RZUEVfTUFYXTsN
CisJc3RydWN0IGV4ZWNtZW1fcmFuZ2UJKnJhbmdlczsNCiB9Ow0KIA0KIC8qKg0KQEAgLTkyLDcg
KzkzLDcgQEAgc3RydWN0IGV4ZWNtZW1fcGFyYW1zIHsNCiAgKiBSZXR1cm46IGEgc3RydWN0dXJl
IGRlZmluaW5nIGFyY2hpdGVjdHVyZSBwYXJhbWV0ZXJzIGFuZA0KcmVzdHJpY3Rpb25zDQogICog
Zm9yIGFsbG9jYXRpb25zIG9mIGV4ZWN1dGFibGUgbWVtb3J5DQogICovDQotc3RydWN0IGV4ZWNt
ZW1fcGFyYW1zICpleGVjbWVtX2FyY2hfcGFyYW1zKHZvaWQpOw0KK3ZvaWQgZXhlY21lbV9hcmNo
X3BhcmFtcyhzdHJ1Y3QgZXhlY21lbV9wYXJhbXMgKnApOw0KIA0KIC8qKg0KICAqIGV4ZWNtZW1f
dGV4dF9hbGxvYyAtIGFsbG9jYXRlIGV4ZWN1dGFibGUgbWVtb3J5DQpkaWZmIC0tZ2l0IGEvbW0v
ZXhlY21lbS5jIGIvbW0vZXhlY21lbS5jDQppbmRleCBhZWZmODUyNjEzNjAuLmRmZGVjOGMyYjA3
NCAxMDA2NDQNCi0tLSBhL21tL2V4ZWNtZW0uYw0KKysrIGIvbW0vZXhlY21lbS5jDQpAQCAtNiwx
NSArNiwxNSBAQA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGVsb2FkZXIuaD4NCiANCiBzdGF0aWMg
c3RydWN0IGV4ZWNtZW1fcGFyYW1zIGV4ZWNtZW1fcGFyYW1zOw0KK3N0YXRpYyBzdHJ1Y3QgZXhl
Y21lbV9yYW5nZSBkZWZhdWx0X3JhbmdlOw0KIA0KLXN0YXRpYyB2b2lkICpleGVjbWVtX2FsbG9j
KHNpemVfdCBzaXplLCBzdHJ1Y3QgZXhlY21lbV9yYW5nZSAqcmFuZ2UpDQorc3RhdGljIHZvaWQg
KmV4ZWNtZW1fYWxsb2Moc2l6ZV90IHNpemUsIHN0cnVjdCBleGVjbWVtX3JhbmdlICpyYW5nZSwN
CnBncHJvdF90IHBncHJvdCkNCiB7DQogCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSByYW5nZS0+c3Rh
cnQ7DQogCXVuc2lnbmVkIGxvbmcgZW5kID0gcmFuZ2UtPmVuZDsNCiAJdW5zaWduZWQgbG9uZyBm
YWxsYmFja19zdGFydCA9IHJhbmdlLT5mYWxsYmFja19zdGFydDsNCiAJdW5zaWduZWQgbG9uZyBm
YWxsYmFja19lbmQgPSByYW5nZS0+ZmFsbGJhY2tfZW5kOw0KIAl1bnNpZ25lZCBpbnQgYWxpZ24g
PSByYW5nZS0+YWxpZ25tZW50Ow0KLQlwZ3Byb3RfdCBwZ3Byb3QgPSByYW5nZS0+cGdwcm90Ow0K
IAlib29sIGthc2FuID0gcmFuZ2UtPmZsYWdzICYgRVhFQ01FTV9LQVNBTl9TSEFET1c7DQogCXVu
c2lnbmVkIGxvbmcgdm1fZmxhZ3MgID0gVk1fRkxVU0hfUkVTRVRfUEVSTVM7DQogCWJvb2wgZmFs
bGJhY2sgID0gISFmYWxsYmFja19zdGFydDsNCkBAIC02MCwxNCArNjAsMTggQEAgc3RhdGljIGlu
bGluZSBib29sIGV4ZWNtZW1fcmFuZ2VfaXNfZGF0YShlbnVtDQpleGVjbWVtX3R5cGUgdHlwZSkN
CiANCiB2b2lkICpleGVjbWVtX3RleHRfYWxsb2MoZW51bSBleGVjbWVtX3R5cGUgdHlwZSwgc2l6
ZV90IHNpemUpDQogew0KLQlyZXR1cm4gZXhlY21lbV9hbGxvYyhzaXplLCAmZXhlY21lbV9wYXJh
bXMucmFuZ2VzW3R5cGVdKTsNCisJc3RydWN0IGV4ZWNtZW1fcmFuZ2UgKnJhbmdlID0NCiZleGVj
bWVtX3BhcmFtcy5yYW5nZXNbZXhlY21lbV9wYXJhbXMuYXJlYXNbdHlwZV1dOw0KKw0KKwlyZXR1
cm4gZXhlY21lbV9hbGxvYyhzaXplLCByYW5nZSwgcmFuZ2UtPnBncHJvdCk7DQogfQ0KIA0KIHZv
aWQgKmV4ZWNtZW1fZGF0YV9hbGxvYyhlbnVtIGV4ZWNtZW1fdHlwZSB0eXBlLCBzaXplX3Qgc2l6
ZSkNCiB7DQorCXN0cnVjdCBleGVjbWVtX3JhbmdlICpyYW5nZSA9DQomZXhlY21lbV9wYXJhbXMu
cmFuZ2VzW2V4ZWNtZW1fcGFyYW1zLmFyZWFzW3R5cGVdXTsNCisNCiAJV0FSTl9PTl9PTkNFKCFl
eGVjbWVtX3JhbmdlX2lzX2RhdGEodHlwZSkpOw0KIA0KLQlyZXR1cm4gZXhlY21lbV9hbGxvYyhz
aXplLCAmZXhlY21lbV9wYXJhbXMucmFuZ2VzW3R5cGVdKTsNCisJcmV0dXJuIGV4ZWNtZW1fYWxs
b2Moc2l6ZSwgcmFuZ2UsIFBBR0VfS0VSTkVMKTsNCiB9DQogDQogdm9pZCBleGVjbWVtX2ZyZWUo
dm9pZCAqcHRyKQ0KQEAgLTgwLDkgKzg0LDEzIEBAIHZvaWQgZXhlY21lbV9mcmVlKHZvaWQgKnB0
cikNCiAJdmZyZWUocHRyKTsNCiB9DQogDQotc3RydWN0IGV4ZWNtZW1fcGFyYW1zICogX193ZWFr
IGV4ZWNtZW1fYXJjaF9wYXJhbXModm9pZCkNCit2b2lkIF9fd2VhayBleGVjbWVtX2FyY2hfcGFy
YW1zKHN0cnVjdCBleGVjbWVtX3BhcmFtcyAqcCkNCiB7DQotCXJldHVybiBOVUxMOw0KKwlwLT5y
YW5nZXMgPSBkZWZhdWx0X3JhbmdlOw0KKwlwLT5yYW5nZXNbRVhFQ01FTV9ERUZBVUxUXS5zdGFy
dCA9IFZNQUxMT0NfU1RBUlQ7DQorCXAtPnJhbmdlc1tFWEVDTUVNX0RFRkFVTFRdLmVuZCA9IFZN
QUxMT0NfRU5EOw0KKwlwLT5yYW5nZXNbRVhFQ01FTV9ERUZBVUxUXS5wZ3Byb3QgPSBQQUdFX0tF
Uk5FTF9FWEVDOw0KKwlwLT5yYW5nZXNbRVhFQ01FTV9ERUZBVUxUXS5hbGlnbm1lbnQgPSAxOw0K
IH0NCiANCiBzdGF0aWMgYm9vbCBleGVjbWVtX3ZhbGlkYXRlX3BhcmFtcyhzdHJ1Y3QgZXhlY21l
bV9wYXJhbXMgKnApDQpAQCAtOTcsNDYgKzEwNSw5IEBAIHN0YXRpYyBib29sIGV4ZWNtZW1fdmFs
aWRhdGVfcGFyYW1zKHN0cnVjdA0KZXhlY21lbV9wYXJhbXMgKnApDQogCXJldHVybiB0cnVlOw0K
IH0NCiANCi1zdGF0aWMgdm9pZCBleGVjbWVtX2luaXRfbWlzc2luZyhzdHJ1Y3QgZXhlY21lbV9w
YXJhbXMgKnApDQotew0KLQlzdHJ1Y3QgZXhlY21lbV9yYW5nZSAqZGVmYXVsdF9yYW5nZSA9ICZw
LQ0KPnJhbmdlc1tFWEVDTUVNX0RFRkFVTFRdOw0KLQ0KLQlmb3IgKGludCBpID0gRVhFQ01FTV9E
RUZBVUxUICsgMTsgaSA8IEVYRUNNRU1fVFlQRV9NQVg7IGkrKykgew0KLQkJc3RydWN0IGV4ZWNt
ZW1fcmFuZ2UgKnIgPSAmcC0+cmFuZ2VzW2ldOw0KLQ0KLQkJaWYgKCFyLT5zdGFydCkgew0KLQkJ
CWlmIChleGVjbWVtX3JhbmdlX2lzX2RhdGEoaSkpDQotCQkJCXItPnBncHJvdCA9IFBBR0VfS0VS
TkVMOw0KLQkJCWVsc2UNCi0JCQkJci0+cGdwcm90ID0gZGVmYXVsdF9yYW5nZS0+cGdwcm90Ow0K
LQkJCXItPmFsaWdubWVudCA9IGRlZmF1bHRfcmFuZ2UtPmFsaWdubWVudDsNCi0JCQlyLT5zdGFy
dCA9IGRlZmF1bHRfcmFuZ2UtPnN0YXJ0Ow0KLQkJCXItPmVuZCA9IGRlZmF1bHRfcmFuZ2UtPmVu
ZDsNCi0JCQlyLT5mbGFncyA9IGRlZmF1bHRfcmFuZ2UtPmZsYWdzOw0KLQkJCXItPmZhbGxiYWNr
X3N0YXJ0ID0gZGVmYXVsdF9yYW5nZS0NCj5mYWxsYmFja19zdGFydDsNCi0JCQlyLT5mYWxsYmFj
a19lbmQgPSBkZWZhdWx0X3JhbmdlLT5mYWxsYmFja19lbmQ7DQotCQl9DQotCX0NCi19DQotDQog
dm9pZCBfX2luaXQgZXhlY21lbV9pbml0KHZvaWQpDQogew0KLQlzdHJ1Y3QgZXhlY21lbV9wYXJh
bXMgKnAgPSBleGVjbWVtX2FyY2hfcGFyYW1zKCk7DQorCWV4ZWNtZW1fYXJjaF9wYXJhbXMoJmV4
ZWNtZW1fcGFyYW1zKTsNCiANCi0JaWYgKCFwKSB7DQotCQlwID0gJmV4ZWNtZW1fcGFyYW1zOw0K
LQkJcC0+cmFuZ2VzW0VYRUNNRU1fREVGQVVMVF0uc3RhcnQgPSBWTUFMTE9DX1NUQVJUOw0KLQkJ
cC0+cmFuZ2VzW0VYRUNNRU1fREVGQVVMVF0uZW5kID0gVk1BTExPQ19FTkQ7DQotCQlwLT5yYW5n
ZXNbRVhFQ01FTV9ERUZBVUxUXS5wZ3Byb3QgPSBQQUdFX0tFUk5FTF9FWEVDOw0KLQkJcC0+cmFu
Z2VzW0VYRUNNRU1fREVGQVVMVF0uYWxpZ25tZW50ID0gMTsNCi0NCi0JCXJldHVybjsNCi0JfQ0K
LQ0KLQlpZiAoIWV4ZWNtZW1fdmFsaWRhdGVfcGFyYW1zKHApKQ0KLQkJcmV0dXJuOw0KLQ0KLQll
eGVjbWVtX2luaXRfbWlzc2luZyhwKTsNCi0NCi0JZXhlY21lbV9wYXJhbXMgPSAqcDsNCisJZXhl
Y21lbV92YWxpZGF0ZV9wYXJhbXMoJmV4ZWNtZW1fcGFyYW1zKTsNCiB9DQoNCg==
