Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0920C275FF
	for <lists+linux-s390@lfdr.de>; Thu, 23 May 2019 08:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfEWGcL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 23 May 2019 02:32:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfEWGcL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 May 2019 02:32:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73F3FDD9F4;
        Thu, 23 May 2019 06:32:11 +0000 (UTC)
Received: from gondolin (ovpn-116-44.ams2.redhat.com [10.36.116.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC8EC648DE;
        Thu, 23 May 2019 06:32:09 +0000 (UTC)
Date:   Thu, 23 May 2019 08:32:06 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Farhan Ali <alifm@linux.ibm.com>
Cc:     Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/3] s390: vfio-ccw fixes
Message-ID: <20190523083206.07e374bf.cohuck@redhat.com>
In-Reply-To: <0769d5bc-cf0b-3a66-7d35-381490a115b5@linux.ibm.com>
References: <20190516161403.79053-1-farman@linux.ibm.com>
        <0769d5bc-cf0b-3a66-7d35-381490a115b5@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 23 May 2019 06:32:11 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 22 May 2019 08:20:43 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 05/16/2019 12:14 PM, Eric Farman wrote:
> > Here are the remaining patches in my fixes series, to handle the more
> > involved scenario of channel programs that do not move any actual data
> > to/from the device.  They were reordered per feedback from v2, which
> > means they received minor massaging because of overlapping code and
> > some cleanup to the commit messages.
> > 
> > They are based on Conny's vfio-ccw tree.  :)
> > 
> > Changelog:
> >   v2 -> v3:
> >    - Patches 1-4:
> >       - [Farhan] Added r-b
> >       - [Cornelia] Queued to vfio-ccw, dropped from this version
> >    - Patches 5/6:
> >       - [Cornelia/Farhan] Swapped the order of these patches, minor
> >         rework on the placement of bytes/idaw_nr variables and the
> >         commit messages that resulted.
> >   v2: https://patchwork.kernel.org/cover/10944075/
> >   v1: https://patchwork.kernel.org/cover/10928799/
> > 
> > Eric Farman (3):
> >    s390/cio: Don't pin vfio pages for empty transfers
> >    s390/cio: Allow zero-length CCWs in vfio-ccw
> >    s390/cio: Remove vfio-ccw checks of command codes
> > 
> >   drivers/s390/cio/vfio_ccw_cp.c | 92 ++++++++++++++++++++++++----------
> >   1 file changed, 65 insertions(+), 27 deletions(-)
> >   
> 
> 
> Acked-by: Farhan Ali <alifm@linux.ibm.com> for the series.

Thank you!
