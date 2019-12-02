Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E8210EAC1
	for <lists+linux-s390@lfdr.de>; Mon,  2 Dec 2019 14:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLBNXs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 2 Dec 2019 08:23:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54572 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLBNXs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 08:23:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2DDtiY189327;
        Mon, 2 Dec 2019 13:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=lvL2v5/9s65mI9ICfvlygGG0GLb30F3h6S0EXVBKFIU=;
 b=pclpludXabakobwoELkWMRshMlSsXksgKbs6/Bb00tkveiQvmd9lYX7ITCGpll6H5+hU
 hquLQTUF4zWMpG128yQlUIznBApCDpo8hyopXR0VgcFa3UQvus81ttERBgwnE2jvVDnm
 zrhKSsOn8YjMPdwRECnIhebQgMp55230AeuhAUyWysKPLIT9ouQqihfwQt5AtWuDQX8K
 MCBydZ7ByDF4QJD6C1Kd9rqiJ6jbnZnjegy2kRjNXmM6aYIH1NcgQJGELo93yW7vVl7u
 lBNkMxKO6bio1erKCwkaDfNTljOQJiR1BOrTU/h8iuhW3iocWQIfC6cgdLiHZ62faoTm SA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wkh2qytd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 13:23:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2DMk0K048045;
        Mon, 2 Dec 2019 13:23:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wm1xmxpkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 13:23:23 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB2DNNiR024799;
        Mon, 2 Dec 2019 13:23:23 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 05:23:22 -0800
Date:   Mon, 2 Dec 2019 16:23:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ubraun@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
Subject: Re: [bug report] net/smc: fix ethernet interface refcounting
Message-ID: <20191202132316.GA1787@kadam>
References: <20191202131233.2b4daujqmi27tecx@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202131233.2b4daujqmi27tecx@kili.mountain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020121
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Oops...  I read the caller and it's fine.  My bad.

regards,
dan carpenter

On Mon, Dec 02, 2019 at 04:12:33PM +0300, Dan Carpenter wrote:
> Hello Ursula Braun,
> 
> The patch 98f3375505b8: "net/smc: fix ethernet interface refcounting"
> from Nov 6, 2019, leads to the following static checker warning:
> 
> 	net/smc/smc_pnet.c:379 smc_pnet_fill_entry()
> 	warn: 'pnetelem->ndev' held on error path.
> 
> net/smc/smc_pnet.c
>    329  static int smc_pnet_fill_entry(struct net *net,
>    330                                 struct smc_user_pnetentry *pnetelem,
>    331                                 struct nlattr *tb[])
>    332  {
>    333          char *string, *ibname;
>    334          int rc;
>    335  
>    336          memset(pnetelem, 0, sizeof(*pnetelem));
>    337          INIT_LIST_HEAD(&pnetelem->list);
>    338  
>    339          rc = -EINVAL;
>    340          if (!tb[SMC_PNETID_NAME])
>    341                  goto error;
>    342          string = (char *)nla_data(tb[SMC_PNETID_NAME]);
>    343          if (!smc_pnetid_valid(string, pnetelem->pnet_name))
>    344                  goto error;
>    345  
>    346          rc = -EINVAL;
>    347          if (tb[SMC_PNETID_ETHNAME]) {
>    348                  string = (char *)nla_data(tb[SMC_PNETID_ETHNAME]);
>    349                  pnetelem->ndev = dev_get_by_name(net, string);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> dev_hold().
> 
>    350                  if (!pnetelem->ndev)
>    351                          goto error;
>    352          }
>    353  
>    354          /* if this is not the initial namespace, stop here */
>    355          if (net != &init_net)
>    356                  return 0;
>    357  
>    358          rc = -EINVAL;
>    359          if (tb[SMC_PNETID_IBNAME]) {
>    360                  ibname = (char *)nla_data(tb[SMC_PNETID_IBNAME]);
>    361                  ibname = strim(ibname);
>    362                  pnetelem->smcibdev = smc_pnet_find_ib(ibname);
>    363                  pnetelem->smcd_dev = smc_pnet_find_smcd(ibname);
>    364                  if (!pnetelem->smcibdev && !pnetelem->smcd_dev)
>    365                          goto error;
>                                 ^^^^^^^^^^
> Smatch thinks these require dev_put()
> 
>    366                  if (pnetelem->smcibdev) {
>    367                          if (!tb[SMC_PNETID_IBPORT])
>    368                                  goto error;
>    369                          pnetelem->ib_port = nla_get_u8(tb[SMC_PNETID_IBPORT]);
>    370                          if (pnetelem->ib_port < 1 ||
>    371                              pnetelem->ib_port > SMC_MAX_PORTS)
>    372                                  goto error;
>                                         ^^^^^^^^^^
>    373                  }
>    374          }
>    375  
>    376          return 0;
>    377  
>    378  error:
> 
> So maybe this should be:
> 
> 	if (pnetelem->ndev && tb[SMC_PNETID_ETHNAME])
> 		dev_put(pnetelem->ndev);
> 
>    379          return rc;
>    380  }
> 
> regards,
> dan carpenter
