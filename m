Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6F26626E
	for <lists+linux-s390@lfdr.de>; Fri, 11 Sep 2020 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIKPqY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 11 Sep 2020 11:46:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726573AbgIKPoo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Sep 2020 11:44:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BEW4MI072102;
        Fri, 11 Sep 2020 10:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+66k6A9+xpG1eTE8Frslqaczv5pr64SgcFRfzUEHUiU=;
 b=W1Y9d4N+UqmeBqUrZWtC8Rm1I96XTAB6lrAoTVl6HwPUeXAwhIh511VpYkc7mqrsnIXO
 318MOJwsliQLdeEnQaokP4oF1FZ5VRxfXZU6C3z5uQ8aGRxJ9Vnyq4f3PgKg3znr059j
 y4meqXd36SlJFRYeguzLHuBMm/2OmP/tCgROSn0y7aj7YeEtCQNkDjdZDt6rJVRQa9sj
 SznYqq6YAI17FszngX4kAe1pXN2d4fldca1VWYabcnRKeIE5tCj5VNHkbKer769dnYtk
 m52CI9MspXkAhdHQRmFZjM6dkoQOwbMeyREp5Al+cyhzwh81jb9TB8keSGKy6G7D338e fw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33gabr1tx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 10:39:06 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BEaQMR003009;
        Fri, 11 Sep 2020 14:39:05 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 33c2a9vntc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 14:39:05 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BEd4fA56295734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 14:39:04 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92061124060;
        Fri, 11 Sep 2020 14:39:04 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BEA2124055;
        Fri, 11 Sep 2020 14:39:03 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.91.207])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 14:39:03 +0000 (GMT)
Subject: Re: s390 PCI dma ops
To:     Christoph Hellwig <hch@lst.de>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org
References: <20200911072734.GA23043@lst.de>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <73550e74-1fda-cc34-0e14-54e2b7e76e99@linux.ibm.com>
Date:   Fri, 11 Sep 2020 10:39:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911072734.GA23043@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_05:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110114
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 9/11/20 3:27 AM, Christoph Hellwig wrote:
> Hi S/390 PCI and IOMMU maintainers,
> 
> We've recently tried to convert all implementations of the IOMMU API to
> use drivers/iommu/dma-iommu.c instead of their local IOMMU ops.  I've
> looked at S/390 and while some comments mention things about the iommu
> API the implementation looks quite separate.  Do arch/s390/pci/pci_dma.c
> and drivers/iommu/s390-iommu.c driver the same hardware?  If so would a

Yes, these drivers are dealing with the same hardware.

> switch to drivers/iommu/dma-iommu.c be feasibel?
> 

Hmm...  s390 does some particular things that are arch-specific, largely 
as forms of optimization.  One such example is a case where we avoid 
reusing IO TLB Page Table Entries until we have to do a global flush.

I'd need to take a closer look at what AMD did / what intel is doing. 
Fundamentally we are open to the idea as the maintenance benefit is 
clear, but I don't think it's a trivial swap - I think we would need 
extensions to dma-iommu to accommodate some of our special cases / 
optimizations.
