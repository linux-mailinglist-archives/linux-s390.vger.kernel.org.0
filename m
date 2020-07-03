Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A905213668
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2020 10:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgGCIcG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Jul 2020 04:32:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725648AbgGCIcG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 04:32:06 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06383jRL065716;
        Fri, 3 Jul 2020 04:32:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32121r646e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 04:32:03 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06383jEB065715;
        Fri, 3 Jul 2020 04:32:02 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32121r644y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 04:32:02 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0638VK5v004231;
        Fri, 3 Jul 2020 08:31:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3217b01evx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 08:31:59 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0638VuJh59768898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jul 2020 08:31:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABDCE4C052;
        Fri,  3 Jul 2020 08:31:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47A2C4C044;
        Fri,  3 Jul 2020 08:31:56 +0000 (GMT)
Received: from osiris (unknown [9.171.55.4])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Jul 2020 08:31:56 +0000 (GMT)
Date:   Fri, 3 Jul 2020 10:31:54 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 1/2] mm/memblock: expose only miminal interface to
 add/walk physmem
Message-ID: <20200703083154.GD4582@osiris>
References: <20200701141830.18749-1-david@redhat.com>
 <20200701141830.18749-2-david@redhat.com>
 <20200701150643.GA2999146@linux.ibm.com>
 <20200701153157.GC5008@osiris>
 <9a6728b2-05d3-0e98-dc45-a3e4821e0539@redhat.com>
 <20200702214852.f6ab03dc8d072abf35359d3b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702214852.f6ab03dc8d072abf35359d3b@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-03_02:2020-07-02,2020-07-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 cotscore=-2147483648 mlxscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=1 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007030059
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 02, 2020 at 09:48:52PM -0700, Andrew Morton wrote:
> On Thu, 2 Jul 2020 09:23:10 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > >>> ---
> > >>>  arch/s390/kernel/crash_dump.c |  6 ++--
> > >>>  include/linux/memblock.h      | 28 ++++++++++++++---
> > >>>  mm/memblock.c                 | 57 ++++++++++++++++++-----------------
> > >>>  3 files changed, 55 insertions(+), 36 deletions(-)
> > > 
> > > So I guess this should go via the s390 tree, since the second patch of
> > > this series can go only upstream if both this patch and a patch which
> > > is currently only on our features are merged before.
> > > 
> > > Any objections?
> > 
> > @Andrew, fine with you if this goes via the s390 tree?
> 
> Sure, please go ahead.

Ok, applied both patches. Thanks!
