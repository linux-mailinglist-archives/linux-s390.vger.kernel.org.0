Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E991F21BC
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2020 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgFHWL3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 Jun 2020 18:11:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbgFHWL3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 18:11:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058M4pLw083317;
        Mon, 8 Jun 2020 18:11:28 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31g5fcdj5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 18:11:28 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 058MBIi7016910;
        Mon, 8 Jun 2020 22:11:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7vr9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 22:11:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 058MBNxY50462888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jun 2020 22:11:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68144A4040;
        Mon,  8 Jun 2020 22:11:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C8C9A404D;
        Mon,  8 Jun 2020 22:11:23 +0000 (GMT)
Received: from localhost (unknown [9.145.156.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  8 Jun 2020 22:11:22 +0000 (GMT)
Date:   Tue, 9 Jun 2020 00:11:21 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [GIT PULL] s390 patches for the 5.8 merge window
Message-ID: <your-ad-here.call-01591654281-ext-4683@work.hours>
References: <your-ad-here.call-01591630479-ext-3636@work.hours>
 <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
 <CAHk-=whnntptk9j7KgtPQY5yNEkL5J64mAsqZgdV_4FLtiFboQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whnntptk9j7KgtPQY5yNEkL5J64mAsqZgdV_4FLtiFboQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=840 malwarescore=0
 lowpriorityscore=0 suspectscore=1 phishscore=0 cotscore=-2147483648
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080149
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 08, 2020 at 12:12:57PM -0700, Linus Torvalds wrote:
> On Mon, Jun 8, 2020 at 12:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Jun 8, 2020 at 8:35 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> > >
> > > Please note 2 minor merge conflict resolutions below:
> >
> > There was a third because of the iommu tree I merged today.

Looks fine, thank you.

> Oh, and please don't post the whole patch in your pull request.

Yes, this was not intentional. Sorry about that.

Vasily
