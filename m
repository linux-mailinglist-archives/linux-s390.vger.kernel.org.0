Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3042CC47EE
	for <lists+linux-s390@lfdr.de>; Wed,  2 Oct 2019 08:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfJBGuI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 2 Oct 2019 02:50:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbfJBGuG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Oct 2019 02:50:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x926gqbX051259
        for <linux-s390@vger.kernel.org>; Wed, 2 Oct 2019 02:50:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vcpb3h28x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 02 Oct 2019 02:50:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 2 Oct 2019 07:50:03 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Oct 2019 07:50:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x926nw9N50593922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Oct 2019 06:49:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ADAFA4040;
        Wed,  2 Oct 2019 06:49:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 557C0A404D;
        Wed,  2 Oct 2019 06:49:58 +0000 (GMT)
Received: from osiris (unknown [9.152.212.201])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Oct 2019 06:49:58 +0000 (GMT)
Date:   Wed, 2 Oct 2019 08:49:56 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Jiri Kosina <jikos@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.4-rc1 BUILD FIX] s390: mark __cpacf_query() as
 __always_inline
References: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
 <20191002064605.GA7405@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002064605.GA7405@osiris>
X-TM-AS-GCONF: 00
x-cbid: 19100206-0020-0000-0000-000003743B4B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100206-0021-0000-0000-000021CA3DB6
Message-Id: <20191002064956.GB7405@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910020062
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 02, 2019 at 08:46:05AM +0200, Heiko Carstens wrote:
> On Tue, Oct 01, 2019 at 10:08:01PM +0200, Jiri Kosina wrote:
> > I am wondering how is it possible that none of the build-testing 
> > infrastructure we have running against linux-next caught this? Not enough 
> > non-x86 coverage?
> 
> Well, there is plenty of s390 coverage with respect to daily builds
> (also here). It doesn't fail for me with gcc 9.1; so you may either
> have a different gcc version or different config options(?) so the
> compiler decided to not inline the function. I'll apply this in any
> case, since your patch is obviously fine.
> 
> Thanks!

Ok, Christian applied this already a couple of minutes earlier ;)

