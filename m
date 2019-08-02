Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543EC7ECDD
	for <lists+linux-s390@lfdr.de>; Fri,  2 Aug 2019 08:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbfHBGtk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 2 Aug 2019 02:49:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388971AbfHBGtj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Aug 2019 02:49:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x726b61W099572
        for <linux-s390@vger.kernel.org>; Fri, 2 Aug 2019 02:49:38 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4dbenfce-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 02 Aug 2019 02:49:38 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 2 Aug 2019 07:49:35 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 07:49:33 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x726nVj962128176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 06:49:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B3C4A405C;
        Fri,  2 Aug 2019 06:49:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D96FA405F;
        Fri,  2 Aug 2019 06:49:31 +0000 (GMT)
Received: from osiris (unknown [9.152.212.134])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  2 Aug 2019 06:49:31 +0000 (GMT)
Date:   Fri, 2 Aug 2019 08:49:29 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Patrick Steuer <steuer@linux.ibm.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
References: <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au>
 <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au>
 <20190731114453.GD3488@osiris>
 <20190801122849.GB4163@osiris>
 <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
 <20190802102019.6a789c51@canb.auug.org.au>
 <20190802031414.GB14879@gondor.apana.org.au>
 <20190802144844.43508be1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802144844.43508be1@canb.auug.org.au>
X-TM-AS-GCONF: 00
x-cbid: 19080206-0012-0000-0000-00000338AB23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080206-0013-0000-0000-000021725A68
Message-Id: <20190802064929.GB4158@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020068
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 02, 2019 at 02:48:44PM +1000, Stephen Rothwell wrote:
> Hi Herbert,
> 
> On Fri, 2 Aug 2019 13:14:14 +1000 Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > For now I'm going to back out those two specific patches as the
> > rest seem to be valid by themselves.
> 
> I have applied the top commit from your tree to linux-next today just
> to help with building and testing over the weekend (I had already
> merged your tree before you added the revert).

Thanks Stephen! We don't have any automatic testing coverage on s390
for any linux-next release this week due to the build breakage(s).

