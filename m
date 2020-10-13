Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840E528CEC5
	for <lists+linux-s390@lfdr.de>; Tue, 13 Oct 2020 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgJMMxJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 13 Oct 2020 08:53:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:55326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgJMMxI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Oct 2020 08:53:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F0E2ACB8;
        Tue, 13 Oct 2020 12:53:07 +0000 (UTC)
Date:   Tue, 13 Oct 2020 14:53:03 +0200
From:   Petr Tesarik <ptesarik@suse.cz>
To:     linux-s390@vger.kernel.org
Cc:     Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Is OS_INFO_VMCOREINFO unimplemented?
Message-ID: <20201013145303.6f99fe89@ezekiel.suse.cz>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W94fo0l0R1KWS0gkWgqtsUr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--Sig_/W94fo0l0R1KWS0gkWgqtsUr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I've been looking into kernel crash dump analysis for some time now,
and I've noticed that none of my sample dumps for z/Architecture sets
OS_INFO_VMCOREINFO.

Commit 4857d4bbe9821c8d732cb84455e18e12b3d79add suggests that the
"os_info" structure should contain vmcoreinfo, but it seems that the
corresponding fields are always zero, and a quick grep for
OS_INFO_VMCOREINFO finds only code that tries to read this entry in the
panic kernel, but no code that would initialize it in the old (crashed)
kernel.

In short, the panic kernel always prints an informational message that
entry 0 is not available and falls back to get_vmcoreinfo_old().

Is this a bug, or is this interface used by a non-Linux operating
system that I'm not aware of?

TIA,
Petr Tesarik
SUSE HW Enablement

--Sig_/W94fo0l0R1KWS0gkWgqtsUr
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl+Foy8ACgkQqlA7ya4P
R6eu7QgAhvS1Z1GbfPzbEIhK6amfkFEX0hXWFfxS1yx/n/vaLXbGVjHR3jNXjQfD
DVSe3sz96Jk4/oErCN+icekanjdidleVzcZqgTt++byaECwj0DjgwSFzLWzXQe09
H8HxXE3SyPgaLEXeLQDQsijTqxdXuSckKedvNadPOw5JtQG6KoJnHKKowVvSCUej
ApSmJaeAr0OtZQ814XHZT43NtKLUrrxB/DEm0cP0lC1JmyfxgOogvPSrPxlN0aYP
1NUgI/PWqfzyue/1lLGO+cw+NYNwDmJemLJm85q/G/97a2eROJ0O8oB0Z2Z+/0tZ
/qQWaFsgf/VZn39TOrADA9X65XZdgQ==
=7759
-----END PGP SIGNATURE-----

--Sig_/W94fo0l0R1KWS0gkWgqtsUr--
