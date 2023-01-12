Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D224366788D
	for <lists+linux-s390@lfdr.de>; Thu, 12 Jan 2023 16:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbjALPGH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Jan 2023 10:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbjALPFc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Jan 2023 10:05:32 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93916146A
        for <linux-s390@vger.kernel.org>; Thu, 12 Jan 2023 06:54:16 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id o66so15455432oia.6
        for <linux-s390@vger.kernel.org>; Thu, 12 Jan 2023 06:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A+TwVa7Ei5W+PzH9Ca+c53+yEh5/vjHTxV/toCcLXbQ=;
        b=LpSSTyPmyxpTpA02YcsfpNdvT2NUbvsA/EhfJ2dyq5OUfE8oKutjU7lHYvvEdj88AP
         Y4H6igI0C20vsmU8I4yVdbEbJvGrc+v8E0s0vBbYz5hJgqkrzHpZfgKTbs3yoISsvuFN
         P9GL3HlkFoey5OBqXkGz29GuqfYNHGdz/3fbloHi/9TSo0wKsKYqCcEG6zV01Zmz9Yz6
         YL93m1jTN0Io0OPMISZ2dyFwl14P1TVLepKqoQtmVRAOiu5F7lrfPNi7FxGBvpzqoSQw
         EFMOgaKYwlZY+6DZCsUlx4Lsn2dkOgqihorCPrH4cxpKJ0E03o7sNS9IhnyHbavZthDK
         fqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+TwVa7Ei5W+PzH9Ca+c53+yEh5/vjHTxV/toCcLXbQ=;
        b=WCBApjzGNDSiTtPY71AdrM8nrKXGTebLG8LdnTfsm9rSWgxi7plA6w7jZ7odhQhDMM
         vUJkHh6PNhp3L3HdNHfm6egEDln93v1dM4L90Vr2Zdn4NBVPrd+zjM/iZNB+iChQnji5
         FghordXOQlzz92Tek7XnIk/lusjX/HPU/CbNGqb8RkUDLQlRtSlN5/IuSsIS8dKbOPn4
         VU0N7xjYDXVg6eS0GJEunj+DGG9/7FBNYVvvK/b9Zn6bLFe0LWt1wyc/rEZKsqvDkkfn
         V2i9Gb8KARJR/20193HFjuzQO8NGhtJzQwsbfuc7gE+EzTBRB7DZGgVw3OPVWv4Ykn/5
         0pDQ==
X-Gm-Message-State: AFqh2kqrQhvsMnhiVqHIVWcCe5h8hXlJVc7hW2a2/ndxkvVdSTAQbI7e
        BQ+kvzsNvbR+Mmy1YwguM5XrGGcEIqLlBnAa0A==
X-Google-Smtp-Source: AMrXdXuPKM+OWb6u/VnI7yc3JuyZ62LisIpcvSenJemWAXopzaZPmakqsjc0ybUqpGzgHye1a6khtWdD9dBddEU4s0Y=
X-Received: by 2002:a05:6808:179a:b0:364:6544:b4a9 with SMTP id
 bg26-20020a056808179a00b003646544b4a9mr481942oib.172.1673535255941; Thu, 12
 Jan 2023 06:54:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:392:0:0:0:0:0 with HTTP; Thu, 12 Jan 2023 06:54:15 -0800 (PST)
Reply-To: lisaarobet@gmail.com
In-Reply-To: <63c01ee5.050a0220.6bcee.3385.GMR@mx.google.com>
References: <CAFKPBsFVUxspHREZp-rpZyi9GmwbC64KC0Q9AFLJAyZnUiP=7A@mail.gmail.com>
 <60953a7e.1c69fb81.c987e.4928.GMR@mx.google.com> <CAFKPBsGh9Zv3qC5Zp=DsLyz=w=T_Zi3c=uP58-X0DVZdvyGb7g@mail.gmail.com>
 <60953ea4.1c69fb81.442b7.3742.GMR@mx.google.com> <CAFKPBsE7VLh8GSOQo-VmopxR+sDSOuAJUmFON7SS=zaZ9TkM7Q@mail.gmail.com>
 <db89e535-41c6-4fd1-bfe7-72f671f5de83@DB8PR04MB5916.eurprd04.prod.outlook.com>
 <CAFKPBsEjDfLGGvGWGy_nd9047nyPAYKNbqhXbSWGEE35ntebcA@mail.gmail.com>
 <6217a3a4.1c69fb81.cd2f0.593a.GMR@mx.google.com> <CAFKPBsHBfewnvpaUxe_Z_LB4iFbNqNAsqTjbf7UsB4KET+9eEQ@mail.gmail.com>
 <621a7f1f.1c69fb81.afb34.c577.GMR@mx.google.com> <CAFKPBsHuUudYYxVUtc5r1V3_Trsv5v234-Essso0n8gNQdxh1A@mail.gmail.com>
 <6234ebda.1c69fb81.47e83.d383.GMR@mx.google.com> <CAFKPBsGx7P8ehrd65W9RhOo0DreO7sDSfi1Xp-R7S6n8Kb9f7g@mail.gmail.com>
 <63b9a692.050a0220.4ed49.8721.GMR@mx.google.com> <CAFKPBsEERpxfwEJeOZ6h2_km4SmpF6WiQ4HmgqUn3Yqe==sd4g@mail.gmail.com>
 <63bdd949.170a0220.fa5d3.b9aa.GMR@mx.google.com> <CAFKPBsHrzfKEw5w1d-uyWVD92XUh6ARrbx-i4Knq7akRimjMdw@mail.gmail.com>
 <CAFKPBsHrzfKEw5w1d-uyWVD92XUh6ARrbx-i4Knq7akRimjMdw@mail.gmail.com> <63c01ee5.050a0220.6bcee.3385.GMR@mx.google.com>
From:   Lisa <ecowasmonitoringfundoffice@gmail.com>
Date:   Thu, 12 Jan 2023 14:54:15 +0000
Message-ID: <CAFKPBsEceHrf8N7W4yxSj0ajo-2ZBuv-1Eh=2NGs9_-NPG7vLA@mail.gmail.com>
Subject: Re: Delivery Status Notification (Failure)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ecowasmonitoringfundoffice[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Dear Friend

Compliment of the day, there is something i will like us to discuss,
do you receive my Request?

Thanks
